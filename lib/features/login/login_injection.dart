import 'package:get_it/get_it.dart';
import 'package:momobill/features/login/data/datasources/login_remote_data_source.dart';
import 'package:momobill/features/login/domain/usecases/login_usecase.dart';
import 'package:momobill/features/login/presentation/bloc/login_bloc.dart';

class LoginInjection {
  static void setupServiceLocator(GetIt sl) {
    // Bloc
    sl.registerFactory(() => LoginBloc(loginUseCase: sl()));

    // Use cases
    sl.registerLazySingleton(() => LoginUseCase(sl()));

    // Data sources
    sl.registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSourceImpl(client: sl()));
  }
}
