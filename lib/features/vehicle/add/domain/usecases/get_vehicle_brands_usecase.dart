import 'package:dartz/dartz.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/core/usecase/usecase.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_brand.dart';
import 'package:momobill/features/vehicle/add/domain/repositories/vehicle_properties_repository.dart';

class GetVehicleBrandsUseCase implements UseCase<List<VehicleBrand>, NoParams> {
  final VehiclePropertiesRepository vehiclePropertiesRepository;

  GetVehicleBrandsUseCase({this.vehiclePropertiesRepository});

  @override
  Future<Either<Failure, List<VehicleBrand>>> call(NoParams params) async {
    return await vehiclePropertiesRepository.getVehicleBrands();
  }
}