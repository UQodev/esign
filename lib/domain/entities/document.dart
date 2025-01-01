class Document {
  final String id;
  final String userId;
  final String fileName;
  final String fileUrl;
  final String? signedUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Document({
    required this.id,
    required this.userId,
    required this.fileName,
    required this.fileUrl,
    required this.signedUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}
