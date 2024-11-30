import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<Either<Failure, void>> signOut();
}
