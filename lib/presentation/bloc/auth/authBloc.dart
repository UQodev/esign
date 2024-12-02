import 'package:esign/domain/repositories/auth_repository.dart';
import 'package:esign/presentation/bloc/auth/authEvent.dart';
import 'package:esign/presentation/bloc/auth/authState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      final result = await repository.login(event.email, event.password);

      result.fold((failure) => emit(AuthError('Login Gagal')),
          (user) => emit(AuthSuccess(user)) // Gunakan user dari parameter
          );
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());

      final result =
          await repository.register(event.name, event.email, event.password);

      result.fold((failure) => emit(AuthError('Registrasi Gagal')),
          (user) => emit(AuthSuccess(user)));
    });
  }
}
