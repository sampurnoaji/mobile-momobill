import 'package:dartz/dartz.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/core/usecase/usecase.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_model.dart';
import 'package:momobill/features/vehicle/add/domain/repositories/vehicle_properties_repository.dart';

class GetVehicleModelsUseCase implements UseCase<List<VehicleModel>, NoParams> {
  final VehiclePropertiesRepository vehiclePropertiesRepository;

  GetVehicleModelsUseCase({this.vehiclePropertiesRepository});

  @override
  Future<Either<Failure, List<VehicleModel>>> call(NoParams params) async {
    return await vehiclePropertiesRepository.getVehicleModels();
  }
}