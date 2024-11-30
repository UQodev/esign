import 'package:esign/core/config/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseDataSources {
  SupabaseClient get supabase;
  Future<void> initialize();
}

class SupabaseDataSourceImpl implements SupabaseDataSources {
  @override
  SupabaseClient get supabase => Supabase.instance.client;

  @override
  Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabaseConfig.SUPABSE_URL,
      anonKey: SupabaseConfig.SUPABASE_ANON_KEY,
    );
  }
}
