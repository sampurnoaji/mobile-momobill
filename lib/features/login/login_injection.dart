import 'package:get_it/get_it.dart';
import 'package:momobill/features/login/presentation/bloc/login_bloc.dart';

class LoginInjection {
  static void setupServiceLocator(GetIt sl) {
    sl.registerFactory(() => LoginBloc());
  }
}