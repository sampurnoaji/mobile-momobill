
import 'package:dio/dio.dart';
import 'package:momobill/core/error/exception.dart';
import 'package:momobill/core/network/api/api_base_helper.dart';
import 'package:momobill/features/vehicle/add/data/models/vehicle_brand_response.dart';
import 'package:momobill/features/vehicle/add/data/models/vehicle_model_response.dart';
import 'package:momobill/features/vehicle/add/data/models/vehicle_type_response.dart';

abstract class VehiclePropertiesRemoteDataSource {
  Future<VehicleTypeListResponse> getVehicleTypes();
  Future<VehicleBrandListResponse> getVehicleBrands();
  Future<VehicleModelListResponse> getVehicleModels();
}

class VehiclePropertiesRemoteDataSourceImpl implements VehiclePropertiesRemoteDataSource {
  final Dio dio;

  VehiclePropertiesRemoteDataSourceImpl({this.dio});

  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<VehicleTypeListResponse> getVehicleTypes() async {
    final response = await _helper.get('/napi/photos/Q14J2k8VE3U/related');
    return VehicleTypeListResponse.fromJson(response);
  }

  @override
  Future<VehicleBrandListResponse> getVehicleBrands() async {
    try {
      final response = await dio.get('/napi/photos/Q14J2k8VE3U/related');
      return VehicleBrandListResponse.fromJson(response.data);
    } catch (error) {
      throw ServerErrorException();
    }
  }

  @override
  Future<VehicleModelListResponse> getVehicleModels() async {
    try {
      final response = await dio.get('/napi/photos/Q14J2k8VE3U/related');
      return VehicleModelListResponse.fromJson(response.data);
    } catch (error) {
      throw ServerErrorException();
    }
  }
}
