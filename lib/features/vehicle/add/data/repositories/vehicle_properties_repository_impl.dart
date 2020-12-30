import 'package:dartz/dartz.dart';
import 'package:momobill/core/error/exception.dart';
import 'package:momobill/core/error/failures.dart';
import 'package:momobill/core/network/network_info.dart';
import 'package:momobill/features/vehicle/add/data/datasources/vehicle_properties_remote_data_source.dart';
import 'package:momobill/features/vehicle/add/data/models/vehicle_type_response.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_type.dart';
import 'package:momobill/features/vehicle/add/domain/repositories/vehicle_properties_repository.dart';

class VehiclePropertiesRepositoryImpl implements VehiclePropertiesRepository {
  final VehiclePropertiesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  VehiclePropertiesRepositoryImpl({this.remoteDataSource, this.networkInfo});

  @override
  Future<Either<Failure, List<VehicleType>>> getVehicleTypes() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getVehicleTypes();
        return Right(response.toDomainModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
