abstract class IAuthRepository {
  Future<bool> login(String email, String password);
  Future<void> logout();
  Stream<bool> isLoggedIn();
  String? get currentUserId;
}
