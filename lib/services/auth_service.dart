import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final GoTrueClient _supabaseAuth = Supabase.instance.client.auth;
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(
      String email, String password, Map<String, dynamic> data) async {
    try {
      final AuthResponse res = await _supabaseAuth.signUp(
        email: email,
        password: password,
      );
      if (res.user != null) {
        await _createProfile(res.user!, data);
        return res.user;
      }
      return null;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // Create user profile
  Future<void> _createProfile(User user, Map<String, dynamic> data) async {
    try {
      await _supabaseClient.from('profiles').insert({
        'id': user.id,
        'name': data['name'],
        'email': user.email,
        'role': data['role'].toString(),
        'department': data['department'].toString(),
        'faculty': data['faculty'].toString(),
        'student_id': data['studentId'],
      });
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final AuthResponse res = await _supabaseAuth.signInWithPassword(
        email: email,
        password: password,
      );
      return res.user;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _supabaseAuth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _supabaseAuth.currentUser;
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabaseAuth.resetPasswordForEmail(email);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // Stream of authentication changes
  Stream<User?> get user {
    return _supabaseAuth.onAuthStateChange
        .map((authState) => authState.session?.user);
  }
}