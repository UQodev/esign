import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';
import 'package:esign/data/models/document_model.dart';
import 'package:esign/domain/entities/document.dart';
import 'package:esign/domain/repositories/documents_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DocumentRepositoryImpl implements DocumentsRepository {
  final SupabaseClient supabase;

  DocumentRepositoryImpl({required this.supabase});

  @override
  Future<Either<Failure, List<Document>>> getDocuments(String userId) async {
    try {
      print('Repository: Fetching documents for user: $userId');

      final response =
          await supabase.from('documents').select().eq('user_id', userId);

      print('Repository: Raw response: $response');

      if (response == null) {
        print('Repository: No documents found');
        return const Right([]);
      }

      final documents =
          (response as List).map((doc) => DocumentModel.fromJson(doc)).toList();

      print('Repository: Documents found: ${documents.length}');
      return Right(documents);
    } catch (e, stackTrace) {
      print('Repository: Error getting documents: $e');
      print('Repository: Stack trace: $stackTrace');
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Document>> uploadDocuments(
      String userId, String fileName, String fileUrl) async {
    try {
      final response = await supabase
          .from('documents')
          .insert(
              {'user_id': userId, 'file_name': fileName, 'file_url': fileUrl})
          .select()
          .single();

      return Right(DocumentModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Document>> updateSignedDocuments(
      String documentId, String signedUrl) async {
    try {
      final response = await supabase
          .from('documents')
          .update({'signed_url': signedUrl})
          .eq('id', documentId)
          .select()
          .single();

      return Right(DocumentModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
