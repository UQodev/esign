import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';
import 'package:esign/domain/entities/signature.dart';

abstract class SignatureRepository {
  Future<Either<Failure, Signature>> getSignature(String userId);
  Future<Either<Failure, Signature>> saveSignature(
      String userId, String signatureUrl);
  Future<Either<Failure, void>> updateSignature(
      String userId, String signatureUrl);
}
