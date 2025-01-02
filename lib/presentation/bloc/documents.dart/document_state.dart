import 'package:esign/domain/entities/document.dart';

abstract class DocumentState {}

class DocumentInitial extends DocumentState {}

class DocumentLoading extends DocumentState {}

class DocumentError extends DocumentState {
  final String message;
  DocumentError(this.message);
}

class DocumentLoaded extends DocumentState {
  final List<Document> documents;
  DocumentLoaded(this.documents);
}
