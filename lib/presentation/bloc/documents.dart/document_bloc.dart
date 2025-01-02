import 'package:esign/domain/repositories/documents_repository.dart';
import 'package:esign/presentation/bloc/documents.dart/document_event.dart';
import 'package:esign/presentation/bloc/documents.dart/document_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final DocumentsRepository repository;

  DocumentBloc(this.repository) : super(DocumentInitial()) {
    on<GetDocuments>((event, emit) async {
      try {
        print('Bloc: Getting documents for user: ${event.userId}');
        emit(DocumentLoading());

        final result = await repository.getDocuments(event.userId);
        result.fold(
          (failure) {
            print('Bloc: Failed to get documents');
            emit(DocumentError('Failed to load documents'));
          },
          (documents) {
            print('Bloc: Got ${documents.length} documents');
            emit(DocumentLoaded(documents));
          },
        );
      } catch (e) {
        print('Bloc: Error in GetDocuments: $e');
        emit(DocumentError('Failed to load documents'));
      }
    });

    on<UploadDocuments>((event, emit) async {
      emit(DocumentLoading());
      final result = await repository.uploadDocuments(
        event.userId,
        event.fileName,
        event.fileUrl,
      );
      result.fold(
        (failure) => emit(DocumentError('Failed to upload document')),
        (document) => add(GetDocuments(userId: event.userId)),
      );
    });

    on<UpdateSignedDocuments>((event, emit) async {
      final currentState = state;
      if (currentState is DocumentLoaded) {
        emit(DocumentLoading());
        final result = await repository.updateSignedDocuments(
          event.documentId,
          event.signedUrl,
        );
        result.fold(
          (failure) => emit(DocumentError('Failed to update document')),
          (document) => add(GetDocuments(
            userId: document.userId,
          )),
        );
      }
    });
  }
}
