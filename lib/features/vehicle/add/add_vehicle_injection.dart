import 'package:get_it/get_it.dart';
import 'package:momobill/features/vehicle/add/presentation/bloc/add_vehicle_bloc.dart';

class AddVehicleInjection {
  static void setupServiceLocator(GetIt sl) {
    // Bloc
    sl.registerFactory(() => AddVehicleBloc());

    // Use cases


    // Data sources

  }
}