import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';
import 'package:esign/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> register(
      String name, String email, String password);
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User?>> checkAuth();
  Future<Either<Failure, void>> logout();
}
