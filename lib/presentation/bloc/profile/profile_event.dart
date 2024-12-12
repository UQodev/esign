import 'dart:typed_data';

// import 'package:esign/domain/entities/signature.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String userId;
  // final Signature? signature;

  LoadProfile({
    required this.userId,
    // required this.signature,
  });
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

class UpdateSignature extends ProfileEvent {
  final String userId;
  final Uint8List signatureBytes;

  UpdateSignature({
    required this.userId,
    required this.signatureBytes,
  });
}
