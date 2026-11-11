
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfile {
  final String id;
  final String email;
  final String name;
  final String role;

  const UserProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
  });

  bool get isSeeker => role == 'seeker';
  bool get isOwner => role == 'owner';
  bool get isAdmin => role == 'admin';
}

class ProfileService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<UserProfile?> getMyProfile() async {
    final user = _client.auth.currentUser;

    if (user == null) return null;

    final data = await _client
        .from('profiles')
        .select('id, full_name, role')
        .eq('id', user.id)
        .maybeSingle();

    if (data == null) return null;

    return UserProfile(
      id: data['id'] as String,
      email: user.email ?? '',
      name: (data['full_name'] ?? '') as String,
      role: (data['role'] ?? 'seeker') as String,
    );
  }
}
