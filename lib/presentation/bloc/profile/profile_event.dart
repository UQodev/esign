abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String userId;

  LoadProfile({required this.userId});
}

class UpdateProfile extends ProfileEvent {
  final String userId;
  final String? fullName;
  final DateTime? birthDate;
  final String? phoneNumber;
  final String? profilePictureUrl;

  UpdateProfile({
    required this.userId,
    this.fullName,
    this.birthDate,
    this.phoneNumber,
    this.profilePictureUrl,
  });
}
