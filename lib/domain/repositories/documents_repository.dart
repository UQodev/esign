import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';
import 'package:esign/domain/entities/document.dart';

abstract class DocumentsRepository {
  Future<Either<Failure, List<Document>>> getDocuments(String userId);
  Future<Either<Failure, Document>> uploadDocuments(
      String userId, String fileName, String fileUrl);
  Future<Either<Failure, Document>> updateSignedDocuments(
      String documentId, String signedUrl);
}
