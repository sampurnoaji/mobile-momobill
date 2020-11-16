import 'package:get_it/get_it.dart';

import 'data/datasources/number_trivia_local_data_source.dart';
import 'data/datasources/number_trivia_remote_data_source.dart';
import 'data/repositories/number_trivia_repository_impl.dart';
import 'domain/repositories/number_trivia_repository.dart';
import 'domain/usecases/get_concrete_number_trivia.dart';
import 'domain/usecases/get_random_number_trivia.dart';
import 'presentation/bloc/number_trivia_bloc.dart';

class NumberTriviaInjection {
  static void setupServiceLocator(GetIt sl) {
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
  }
}
