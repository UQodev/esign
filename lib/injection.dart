import 'package:esign/data/datasources/auth_remote_datasource.dart';
import 'package:esign/data/datasources/profile_remote_datasource.dart';
import 'package:esign/data/datasources/signature_remote_datasource.dart';
import 'package:esign/data/repositories/profile_repository_impl.dart';
import 'package:esign/data/repositories/signature_repository_impl.dart';
import 'package:esign/domain/repositories/auth_repository.dart';
import 'package:esign/data/repositories/auth_repository_impl.dart';
import 'package:esign/domain/repositories/profile_repository.dart';
import 'package:esign/domain/repositories/signature_repository.dart';
import 'package:esign/presentation/bloc/auth/auth_bloc.dart';
import 'package:esign/presentation/bloc/profile/profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabase: getIt<SupabaseClient>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );

  getIt.registerFactory(() => AuthBloc(getIt<AuthRepository>()));

  getIt.registerLazySingleton<SignatureRemoteDataSource>(
      () => SignatureRemoteDataSourceImpl(supabase: getIt()));

  getIt.registerLazySingleton<SignatureRepository>(
      () => SignatureRepositoryImpl(getIt()));

  getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(supabase: getIt()));

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: getIt()),
  );

  getIt.registerFactory(() => ProfileBloc(getIt()));
}
