import 'package:get_it/get_it.dart';
import 'package:momobill/features/vehicle/add/data/datasources/vehicle_properties_remote_data_source.dart';
import 'package:momobill/features/vehicle/add/data/repositories/vehicle_properties_repository_impl.dart';
import 'package:momobill/features/vehicle/add/domain/repositories/vehicle_properties_repository.dart';
import 'package:momobill/features/vehicle/add/domain/usecases/get_vehicle_types_usecase.dart';
import 'package:momobill/features/vehicle/add/presentation/bloc/add_vehicle_bloc.dart';

class AddVehicleInjection {
  static void setupServiceLocator(GetIt sl) {
    // Bloc
    sl.registerFactory(() => AddVehicleBloc(getVehicleTypesUseCase: sl()));

    // Use cases
    sl.registerLazySingleton(
        () => GetVehicleTypesUseCase(vehiclePropertiesRepository: sl()));

    // Data sources
    sl.registerLazySingleton<VehiclePropertiesRemoteDataSource>(
        () => VehiclePropertiesRemoteDataSourceImpl(client: sl()));

    // Data sources
    sl.registerLazySingleton<VehiclePropertiesRepository>(() =>
        VehiclePropertiesRepositoryImpl(
            remoteDataSource: sl(), networkInfo: sl()));
  }
}
