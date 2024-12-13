import 'package:esign/domain/repositories/profile_repository.dart';
import 'package:esign/presentation/bloc/profile/profile_event.dart';
import 'package:esign/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// lib/presentation/bloc/profile/profile_bloc.dart
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());

      final result = await repository.getProfile(event.userId);
      final signatureResult = await repository.getSignature(event.userId);

      result.fold(
        (failure) => emit(ProfileError('Failed to load profile')),
        (profile) {
          if (profile != null) {
            signatureResult.fold(
              (failure) => emit(ProfileLoaded(profile: profile)),
              (signature) => emit(ProfileLoaded(
                profile: profile,
                signature: signature,
              )),
            );
          } else {
            emit(ProfileEmpty());
          }
        },
      );
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      print('Updating profile...');
      final result = await repository.updateProfile(
        userId: event.userId,
        fullName: event.fullName,
        birthDate: event.birthDate,
        phoneNumber: event.phoneNumber,
        profilePictureUrl: event.profilePictureUrl,
      );

      result.fold(
        (failure) {
          print('Update failed: $failure'); // Debug log
          emit(ProfileError('Failed to update profile: ${failure.toString()}'));
        },
        (profile) {
          print('Profile updated successfully'); // Debug log
          add(LoadProfile(userId: event.userId));
        },
      );
    });

    on<UpdateSignature>((event, emit) async {
      emit(ProfileLoading());

      final result =
          await repository.updateSignature(event.userId, event.signatureBytes);

      result.fold(
        (failure) => emit(ProfileError('Failed to update signature')),
        (_) {
          // Reload profile and signature after update
          add(LoadProfile(userId: event.userId));
        },
      );
    });

    on<UpdateProfileAndSignature>((event, emit) async {
      emit(ProfileLoading());

      final result = await repository.updateProfileAndSignature(
        userId: event.userId,
        fullName: event.fullName,
        birthDate: event.birthDate,
        phoneNumber: event.phoneNumber,
        profilePictureUrl: event.profilePictureUrl,
        signatureBytes: event.signatureBytes,
      );

      result.fold(
        (failure) => emit(ProfileError('Failed to update profile')),
        (profile) {
          // Reload profile after update
          add(LoadProfile(userId: event.userId));
        },
      );
    });
  }
}
