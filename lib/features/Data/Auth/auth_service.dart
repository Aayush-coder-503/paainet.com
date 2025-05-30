import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';

//For authentication
class AuthService {
  final supabase = Supabase.instance.client;

  Future<String?> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user != null) {
        await supabase.from('users').insert({
          'id': user.id,
          'email': email,
          'username': username,
        });
        return null; // success
      } else {
        return 'User is null';
      }
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }
}

//Uploading avatar or profile pic
Future<String?> uploadAvatarToSupabase(
    Uint8List fileBytes, String fileName) async {
  final supabase = Supabase.instance.client;
  final userId = supabase.auth.currentUser?.id;
  final path = 'avatars/$userId/${const Uuid().v4()}_$fileName';

  final response = await supabase.storage.from('avatars').uploadBinary(
        path,
        fileBytes,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

  if (response.isEmpty) return null;

  final url = supabase.storage.from('avatars').getPublicUrl(path);
  return url;
}
