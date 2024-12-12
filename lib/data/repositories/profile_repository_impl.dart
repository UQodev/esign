import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';
import 'package:esign/data/datasources/profile_remote_datasource.dart';
import 'package:esign/data/models/profile_model.dart';
import 'package:esign/domain/entities/profile.dart';
import 'package:esign/domain/entities/signature.dart';
import 'package:esign/domain/repositories/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final SupabaseClient supabase;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.supabase,
  });

  @override
  Future<Either<Failure, Profile?>> getProfile(String userId) async {
    try {
      final response = await remoteDataSource.getProfile(userId);
      if (response == null) {
        return const Right(null);
      }
      final profile = ProfileModel.fromJson(response);
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Profile>> updateProfile({
    required String userId,
    required String? fullName,
    required DateTime? birthDate,
    required String? phoneNumber,
    required String? profilePictureUrl,
  }) async {
    try {
      final data = {
        'user_id': userId,
        'full_name': fullName,
        'birth_date': birthDate?.toIso8601String(),
        'phone_number': phoneNumber,
        'profile_picture_url': profilePictureUrl,
      };

      final response = await remoteDataSource.updateProfile(data);
      final profile = ProfileModel.fromJson(response);
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateSignature(
      String userId, Uint8List signatureBytes) async {
    try {
      final fileName = 'signatures/$userId.png';
      await supabase.storage
          .from('signatures')
          .uploadBinary(fileName, signatureBytes);

      final signatureUrl =
          supabase.storage.from('signatures').getPublicUrl(fileName);

      await supabase.from('signatures').upsert({
        'user_id': userId,
        'signature_url': signatureUrl,
      });

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  // lib/data/repositories/profile_repository_impl.dart
  @override
  Future<Either<Failure, Signature?>> getSignature(String userId) async {
    try {
      final response = await supabase
          .from('signatures')
          .select()
          .eq('user_id', userId)
          .single();

      if (response == null) {
        return const Right(null);
      }

      final signature = Signature(
        id: response['id'],
        userId: response['user_id'],
        signatureUrl: response['signature_url'],
      );

      return Right(signature);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
