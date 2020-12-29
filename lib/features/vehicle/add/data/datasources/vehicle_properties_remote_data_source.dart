
import 'package:dio/dio.dart';
import 'package:momobill/core/error/exception.dart';
import 'package:momobill/features/vehicle/add/data/models/result_model.dart';

abstract class VehiclePropertiesRemoteDataSource {
  Future<ResultsModel> getVehicleTypes();
}

class VehiclePropertiesRemoteDataSourceImpl implements VehiclePropertiesRemoteDataSource {
  final Dio dio;

  VehiclePropertiesRemoteDataSourceImpl({this.dio});

  @override
  Future<ResultsModel> getVehicleTypes() async {
    try {
      final response = await dio.get('/napi/photos/Q14J2k8VE3U/related');
      return ResultsModel.fromJson(response.data);
    } catch (error) {
        throw ServerException();
    }
  }
}
