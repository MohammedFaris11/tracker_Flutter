import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  @override
  Stream<bool> isLoggedIn() {
    return _firebaseAuth.authStateChanges().map((user) => user != null);
  }

  @override
  Future<bool> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      // In a real app, handle specific FirebaseAuthException codes
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
