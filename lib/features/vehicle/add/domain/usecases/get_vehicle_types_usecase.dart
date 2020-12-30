import 'package:dartz/dartz.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/core/usecase/usecase.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_type.dart';
import 'package:momobill/features/vehicle/add/domain/repositories/vehicle_properties_repository.dart';

class GetVehicleTypesUseCase implements UseCase<List<VehicleType>, NoParams> {
  final VehiclePropertiesRepository vehiclePropertiesRepository;

  GetVehicleTypesUseCase({this.vehiclePropertiesRepository});

  @override
  Future<Either<Failure, List<VehicleType>>> call(NoParams params) async {
    return await vehiclePropertiesRepository.getVehicleTypes();
  }
}