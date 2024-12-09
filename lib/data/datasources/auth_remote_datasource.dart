import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> register(
      String name, String email, String password);
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> checkAuth();
  Future<void> logout(String? rememberToken);
  Future<void> updateRememberToken(String id, String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabase;

  AuthRemoteDataSourceImpl({required this.supabase});

  @override
  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    try {
      final response = await supabase
          .from('users')
          .insert({
            'name': name,
            'email': email,
            'password': password,
          })
          .select()
          .single();

      if (response == null) {
        throw Exception('Registration failed: $response');
      }
      return response;
    } catch (e) {
      throw Exception('Register failed : $e');
    }
  }

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await supabase.from('users').select().match({
        'email': email,
        'password': password,
      }).single();

      if (response == null) {
        throw Exception('User not found');
      }

      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> updateRememberToken(String userId, String token) async {
    try {
      await supabase
          .from('users')
          .update({'remember_token': token}).match({'id': userId});
    } catch (e) {
      throw Exception('Failed to update token: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> checkAuth() async {
    try {
      final response = await supabase
          .from('users')
          .select()
          .not('remember_token', 'is', null)
          .single();

      return response;
    } catch (e) {
      throw Exception('Auth check failed: $e');
    }
  }

  @override
  Future<void> logout(String? rememberToken) async {
    try {
      if (rememberToken != null) {
        await supabase.from('users').update({'remember_token': null}).match(
            {'remember_token': rememberToken});
      }
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}
