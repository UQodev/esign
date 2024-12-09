import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';
import 'package:esign/data/datasources/signature_remote_datasource.dart';
import 'package:esign/data/models/signature_model.dart';
import 'package:esign/domain/entities/signature.dart';
import 'package:esign/domain/repositories/signature_repository.dart';

class SignatureRepositoryImpl implements SignatureRepository {
  final SignatureRemoteDataSource remoteDataSource;

  SignatureRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Signature>> getSignature(String userId) async {
    try {
      final response = await remoteDataSource.getSignature(userId);
      final signature = SignatureModel.fromJson(response);
      return Right(signature);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Signature>> saveSignature(
      String userId, String signatureUrl) async {
    try {
      final response =
          await remoteDataSource.saveSignature(userId, signatureUrl);
      final signature = SignatureModel.fromJson(response);
      return Right(signature);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateSignature(
      String userId, String signatureUrl) async {
    try {
      await remoteDataSource.updateSignature(userId, signatureUrl);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
