import 'package:esign/domain/entities/signature.dart';

class SignatureModel extends Signature {
  SignatureModel({
    required String id,
    required String userId,
    required String signatureUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          userId: userId,
          signatureUrl: signatureUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory SignatureModel.fromJson(Map<String, dynamic> json) => SignatureModel(
        id: json['id'],
        userId: json['user_id'],
        signatureUrl: json['signature_url'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'signature_url': signatureUrl,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
