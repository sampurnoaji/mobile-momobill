import 'package:get_it/get_it.dart';
import 'package:momobill/features/authentication/bloc/authentication_bloc.dart';
import 'package:momobill/features/login/data/repositories/user_repositories_impl.dart';
import 'package:momobill/features/login/domain/repositories/user_repository.dart';

class AuthenticationInjection {
  static void setupServiceLocator(GetIt sl) {
    sl.registerFactory(() => AuthenticationBloc(sl()));

    sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  }
}