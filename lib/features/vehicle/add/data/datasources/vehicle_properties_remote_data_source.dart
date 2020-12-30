
import 'package:dio/dio.dart';
import 'package:momobill/core/error/exception.dart';
import 'package:momobill/features/vehicle/add/data/models/vehicle_type_response.dart';

abstract class VehiclePropertiesRemoteDataSource {
  Future<VehicleTypeListResponse> getVehicleTypes();
}

class VehiclePropertiesRemoteDataSourceImpl implements VehiclePropertiesRemoteDataSource {
  final Dio dio;

  VehiclePropertiesRemoteDataSourceImpl({this.dio});

  @override
  Future<VehicleTypeListResponse> getVehicleTypes() async {
    try {
      final response = await dio.get('/napi/photos/Q14J2k8VE3U/related');
      return VehicleTypeListResponse.fromJson(response.data);
    } catch (error) {
        throw ServerException();
    }
  }
}
