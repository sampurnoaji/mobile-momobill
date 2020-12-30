import 'package:dartz/dartz.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_type.dart';

abstract class VehiclePropertiesRepository {
  Future<Either<Failure, List<VehicleType>>> getVehicleTypes();
}