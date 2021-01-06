import 'package:dartz/dartz.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_brand.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_type.dart';

abstract class VehiclePropertiesRepository {
  Future<Either<Failure, List<VehicleType>>> getVehicleTypes();
  Future<Either<Failure, List<VehicleBrand>>> getVehicleBrands();
}