import 'package:dio/dio.dart';
import 'package:momobill/core/error/exception.dart';
import 'package:momobill/features/account/data/models/user_account_response.dart';

abstract class UserAccountRemoteDataSource {
  Future<UserAccountResponse> getUserAccount(String userId);
}

class UserAccountRemoteDataSourceImpl implements UserAccountRemoteDataSource {
  final Dio dio;

  UserAccountRemoteDataSourceImpl(this.dio);
  
  @override
  Future<UserAccountResponse> getUserAccount(String userId) async {
    try {
      final response = await dio.get('/users/{userId}');
      return UserAccountResponse.fromJson(response.data);
    } catch (error) {
      throw ServerErrorException();
    }
  }
}
