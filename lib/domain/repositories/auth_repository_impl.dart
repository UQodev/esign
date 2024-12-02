import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';
import 'package:esign/domain/entities/user.dart';
import 'package:esign/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:crypto/crypto.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient supabase;
  final String jwtSecret = 'jwtSecret';

  AuthRepositoryImpl(this.supabase);

  String _hashPassword(String passwrd) {
    var bytes = utf8.encode(passwrd);
    return sha256.convert(bytes).toString();
  }

  String _generateToken(String id) {
    final jwt = JWT({
      'id': id,
      'iat': DateTime.now().millisecondsSinceEpoch,
    });
    return jwt.sign(SecretKey(jwtSecret));
  }

  @override
  Future<Either<Failure, User>> register(
      String name, String email, String password) async {
    try {
      final hashedPassword = _hashPassword(password);

      final response = await supabase
          .from('users')
          .insert({
            'name': name,
            'email': email,
            'password': hashedPassword,
          })
          .select()
          .single();

      final user = User(
        id: response['id'],
        name: response['name'],
        email: response['email'],
        token: _generateToken(response['id']),
        createdAt: DateTime.parse(response['created_at']),
        updatedAt: DateTime.parse(response['updated_at']),
      );

      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final hashedPassword = _hashPassword(password);

      final response = await supabase.from('users').select().match({
        'email': email,
        'password': hashedPassword,
      }).single();

      final user = User(
        id: response['id'],
        name: response['name'],
        email: response['email'],
        token: _generateToken(response['id']),
        createdAt: DateTime.parse(response['created_at']),
        updatedAt: DateTime.parse(response['updated_at']),
      );

      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, void>> logout() async {
    try {
      await supabase.auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
