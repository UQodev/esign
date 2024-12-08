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

      result.fold((failure) => emit(AuthError(failure.message)),
          (user) => emit(AuthSuccess(user)));
    });

    on<CheckAuthEvent>((event, emit) async {
      emit(AuthLoading());

      final result = await repository.checkAuth();

      result.fold((failure) => emit(AuthError(failure.message)), (user) {
        if (user != null) {
          emit(AuthSuccess(user));
        } else {
          emit(AuthInitial());
        }
      });
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());

      final result = await repository.logout();

      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => emit(AuthInitial()),
      );
    });
  }
}
