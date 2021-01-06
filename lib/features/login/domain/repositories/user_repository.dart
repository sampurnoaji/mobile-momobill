import 'package:dartz/dartz.dart';
import 'package:momobill/core/error/failures.dart';

import '../models/login_data.dart';

abstract class UserRepository {
  Future<Either<Failure, LoginData>> login(String username, String password);
  
  Future<String> authenticate(String username, String password);
  Future<void> deleteToken();
  Future<void> persistToken(String token);
  Future<bool> hasToken();
}