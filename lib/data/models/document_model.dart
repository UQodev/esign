import 'package:esign/domain/entities/document.dart';

class DocumentModel extends Document {
  DocumentModel({
    required String id,
    required String userId,
    required String fileName,
    required String fileUrl,
    String? signedUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
            id: id,
            userId: userId,
            fileName: fileName,
            fileUrl: fileUrl,
            signedUrl: signedUrl,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      fileName: json['file_name'] ?? '',
      fileUrl: json['file_url'] ?? '',
      signedUrl: json['signed_url'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'fileName': fileName,
      'fileUrl': fileUrl,
      'signedUrl': signedUrl,
      'createdAt': createdAt.toIso8601String(),
      'updateddAt': createdAt.toIso8601String(),
    };
  }
}
