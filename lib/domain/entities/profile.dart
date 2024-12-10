class Profile {
  final String id;
  final String userId;
  final String? fullName;
  final DateTime? birthDate;
  final String? phoneNumber;
  final String? profilePictureUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Profile({
    required this.id,
    required this.userId,
    this.fullName,
    this.birthDate,
    this.phoneNumber,
    this.profilePictureUrl,
    this.createdAt,
    this.updatedAt,
  });
}
