import 'package:esign/data/datasources/supabase_datasources.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<SupabaseDataSources>(
    () => SupabaseDataSourceImpl(),
  );
}
