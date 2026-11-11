
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  final SupabaseClient _client = Supabase.instance.client;

  User? get currentUser => _client.auth.currentUser;

  Session? get currentSession => _client.auth.currentSession;

  bool get isLoggedIn => currentSession != null;

  Future<AuthResponse> register({
    required String email,
    required String password,
    required String name,
    required String role,
  }) {
    return _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': name,
        'role': role,
      },
    );
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }

  Stream<AuthState> get authStateChanges =>
      _client.auth.onAuthStateChange;

    // Mengambil profil pengguna yang sedang login
  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = currentUser;

    if (user == null) return null;

    final response = await _client
        .from('profiles')
        .select('full_name, role')
        .eq('id', user.id)
        .maybeSingle();

    return response;
  }
}
