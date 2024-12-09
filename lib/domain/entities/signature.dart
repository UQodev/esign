class Signature {
  final String id;
  final String userId;
  final String sigantureUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Signature({
    required this.id,
    required this.userId,
    required this.sigantureUrl,
    this.createdAt,
    this.updatedAt,
  });
}
