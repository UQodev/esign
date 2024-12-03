import 'package:esign/domain/repositories/auth_repository.dart';
import 'package:esign/domain/repositories/auth_repository_impl.dart';
import 'package:esign/presentation/bloc/auth/authBloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<SupabaseClient>()),
  );

  getIt.registerFactory(() => AuthBloc(getIt<AuthRepository>()));
}
