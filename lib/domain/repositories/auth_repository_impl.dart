import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';
import 'package:esign/data/datasources/supabase_datasources.dart';
import 'package:esign/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseDataSources dataSource;

  AuthRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    try {
      final response = await dataSource.supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, void>> signOut() async {
    try {
      await dataSource.supabase.auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
