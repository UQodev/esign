import 'package:dartz/dartz.dart';
import 'package:esign/core/error/failures.dart';
import 'package:esign/data/datasources/profile_remote_datasource.dart';
import 'package:esign/data/models/profile_model.dart';
import 'package:esign/domain/entities/profile.dart';
import 'package:esign/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

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
}
