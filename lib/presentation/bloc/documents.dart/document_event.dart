abstract class DocumentEvent {}

class GetDocuments extends DocumentEvent {
  final String userId;
  GetDocuments({required this.userId});
}

class UploadDocuments extends DocumentEvent {
  final String userId;
  final String fileName;
  final String fileUrl;
  UploadDocuments({
    required this.userId,
    required this.fileName,
    required this.fileUrl,
  });
}

class UpdateSignedDocuments extends DocumentEvent {
  final String documentId;
  final String signedUrl;
  UpdateSignedDocuments({
    required this.documentId,
    required this.signedUrl,
  });
}
