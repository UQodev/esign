class User {
  final int id;
  final String name;
  final String email;
  final String? token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.token,
    this.createdAt,
    this.updatedAt,
  });
}
