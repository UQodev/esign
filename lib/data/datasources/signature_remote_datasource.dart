import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SignatureRemoteDataSource {
  Future<Map<String, dynamic>> getSignature(String userId);
  Future<Map<String, dynamic>> saveSignature(
      String userId, String signatureUrl);
  Future<void> updateSignature(String userId, String signatureUrl);
}

class SignatureRemoteDataSourceImpl implements SignatureRemoteDataSource {
  final SupabaseClient supabase;

  SignatureRemoteDataSourceImpl({required this.supabase});

  @override
  Future<Map<String, dynamic>> getSignature(String userId) async {
    try {
      final response = await supabase
          .from('signatures')
          .select()
          .eq('user_id', userId)
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to get signature: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> saveSignature(
      String userId, String signatureUrl) async {
    try {
      final response = await supabase
          .from('signatures')
          .insert({
            'user_id': userId,
            'signature_url': signatureUrl,
          })
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to insert Signature : $e');
    }
  }

  @override
  Future<void> updateSignature(String userId, String signatureUrl) async {
    try {
      await supabase
          .from('signatures')
          .update({'signature_url': signatureUrl}).eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to update Signature : $e');
    }
  }
}
