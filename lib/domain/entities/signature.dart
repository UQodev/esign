class Signature {
  final String id;
  final String userId;
  final String signatureUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Signature({
    required this.id,
    required this.userId,
    required this.signatureUrl,
    this.createdAt,
    this.updatedAt,
  });
}
