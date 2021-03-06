import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:momobill/core/network/api/api_base_helper.dart';
import 'package:momobill/core/network/dio.dart';
import 'package:momobill/core/network/network_info.dart';
import 'package:momobill/core/presentation/util/input_converter.dart';
import 'package:momobill/features/authentication/authentication_injection.dart';
import 'package:momobill/features/login/login_injection.dart';
import 'package:momobill/features/trivia/number_trivia_injection.dart';
import 'package:momobill/features/vehicle/add/add_vehicle_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => getDio());
  sl.registerLazySingleton(() => ApiBaseHelper());

  // Features
  AuthenticationInjection.setupServiceLocator(sl);
  LoginInjection.setupServiceLocator(sl);
  NumberTriviaInjection.setupServiceLocator(sl);
  AddVehicleInjection.setupServiceLocator(sl);
}
