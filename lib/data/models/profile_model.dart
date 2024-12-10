import 'package:esign/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required String id,
    required String userId,
    String? fullName,
    DateTime? birthDate,
    String? phoneNumber,
    String? profilePictureUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          userId: userId,
          fullName: fullName,
          birthDate: birthDate,
          phoneNumber: phoneNumber,
          profilePictureUrl: profilePictureUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
      id: json['id'],
      userId: json['user_id'],
      fullName: json['full_name'],
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'])
          : null,
      phoneNumber: json['phone_number'],
      profilePictureUrl: json['profile_picture_url'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null);
}
