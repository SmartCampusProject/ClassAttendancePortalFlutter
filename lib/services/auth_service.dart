import 'package:classattendanceportal/enums/user_role.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final GoTrueClient _supabaseAuth = Supabase.instance.client.auth;
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
    Map<String, dynamic> data,
  ) async {
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

  Future<UserRole> getProfileRole(User user) async {
    try {
      final data = await _supabaseClient
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .single();

      final roleString = data['role'] as String?;
      return UserRole.values.firstWhere(
        (role) => role.name.toLowerCase() == roleString?.toLowerCase(),
        orElse: () => UserRole.student,
      );
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

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

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
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

  Future<void> signOut() async {
    await _supabaseAuth.signOut();
  }

  User? getCurrentUser() {
    return _supabaseAuth.currentUser;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabaseAuth.resetPasswordForEmail(email);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Stream<User?> get user {
    return _supabaseAuth.onAuthStateChange.map(
      (authState) => authState.session?.user,
    );
  }
}
