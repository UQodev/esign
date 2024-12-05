import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';
import 'package:esign/data/datasources/auth_remote_datasource.dart';
import 'package:esign/domain/entities/user.dart';
import 'package:esign/domain/repositories/auth_repository.dart';
import 'package:crypto/crypto.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final String jwtSecret = 'jwtSecret';
  User? _currentUser;

  AuthRepositoryImpl(this.remoteDataSource);

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
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

      final response =
          await remoteDataSource.register(name, email, hashedPassword);

      print('Register response: $response');

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
      print('Register error : $e');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final hashedPassword = _hashPassword(password);

      final response = await remoteDataSource.login(email, hashedPassword);
      final token = _generateToken(response['id']);

      final user = User(
        id: response['id'],
        name: response['name'],
        email: response['email'],
        token: token,
        rememberToken: response['remember_token'],
        createdAt: DateTime.parse(response['created_at']),
        updatedAt: DateTime.parse(response['updated_at']),
      );

      _currentUser = user;
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User?>> checkAuth() async {
    try {
      final response = await remoteDataSource.checkAuth();

      if (response != null) {
        final user = User(
          id: response['id'],
          name: response['name'],
          email: response['email'],
          token: response['remember_token'],
          rememberToken: response['remember_token'],
          createdAt: DateTime.parse(response['created_at']),
          updatedAt: DateTime.parse(response['updated_at']),
        );
        _currentUser = user;
        return Right(user);
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      if (_currentUser?.rememberToken != null) {
        await remoteDataSource.logout(_currentUser?.rememberToken);
      }
      _currentUser = null;
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
