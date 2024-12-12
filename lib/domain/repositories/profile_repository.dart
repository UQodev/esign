import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';
import 'package:esign/domain/entities/profile.dart';
import 'package:esign/domain/entities/signature.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile?>> getProfile(String userId);
  Future<Either<Failure, Profile>> updateProfile({
    required String userId,
    required String? fullName,
    required DateTime? birthDate,
    required String? phoneNumber,
    required String? profilePictureUrl,
  });
  Future<Either<Failure, Signature?>> getSignature(String userId);
  Future<Either<Failure, void>> updateSignature(
      String userId, Uint8List signatureBytes);
}
