import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:momobill/core/network/network_info.dart';
import 'package:momobill/core/presentation/util/input_converter.dart';
import 'package:momobill/features/trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:momobill/features/trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:momobill/features/trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:momobill/features/trivia/domain/repositories/number_trivia_repository.dart';
import 'package:momobill/features/trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:momobill/features/trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:momobill/features/trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(() =>
      NumberTriviaBloc(concrete: sl(), random: sl(), inputConverter: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
