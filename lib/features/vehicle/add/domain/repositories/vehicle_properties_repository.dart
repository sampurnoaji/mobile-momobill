import 'package:dartz/dartz.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/features/vehicle/add/domain/models/result.dart';

abstract class VehiclePropertiesRepository {
  Future<Either<Failure, List<Result>>> getVehicleTypes();
}