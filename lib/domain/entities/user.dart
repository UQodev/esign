class User {
  final String id;
  final String name;
  final String email;
  final String? token;
  final String? rememberToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.token,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });
}
