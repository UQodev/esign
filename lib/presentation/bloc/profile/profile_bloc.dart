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
      result.fold(
        (failure) => emit(ProfileError('Failed to load profile')),
        (profile) =>
            emit(profile != null ? ProfileLoaded(profile) : ProfileEmpty()),
      );
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      final result = await repository.updateProfile(
        userId: event.userId,
        fullName: event.fullName,
        birthDate: event.birthDate,
        phoneNumber: event.phoneNumber,
        profilePictureUrl: event.profilePictureUrl,
      );
      result.fold(
        (failure) => emit(ProfileError('Failed to update profile')),
        (profile) => emit(ProfileLoaded(profile)),
      );
    });
  }
}
