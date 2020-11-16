abstract class UserRepository {
  Future<String> authenticate(String username, String password);
  Future<void> deleteToken();
  Future<void> persistToken(String token);
  Future<bool> hasToken();
}