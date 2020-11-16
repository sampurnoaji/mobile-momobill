import 'package:momobill/features/login/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {

  @override
  Future<String> authenticate(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return 'token';
  }

  @override
  Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 2));
    return false;
  }

  @override
  Future<void> persistToken(String token) async {
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  @override
  Future<void> deleteToken() async {
    await Future.delayed(Duration(seconds: 2));
    return;
  }
}