import 'package:esign/domain/entities/profile.dart';
import 'package:esign/domain/entities/signature.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;
  final Signature? signature;
  ProfileLoaded({required this.profile, this.signature});
}

class ProfileEmpty extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
