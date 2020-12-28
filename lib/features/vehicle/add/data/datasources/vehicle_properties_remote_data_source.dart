import 'dart:convert';

import 'package:http/http.dart';
import 'package:momobill/core/error/exception.dart';
import 'package:momobill/features/vehicle/add/data/models/result_model.dart';

abstract class VehiclePropertiesRemoteDataSource {
  Future<ResultsModel> getVehicleTypes();
}

class VehiclePropertiesRemoteDataSourceImpl implements VehiclePropertiesRemoteDataSource {
  final Client client;

  VehiclePropertiesRemoteDataSourceImpl({this.client});

  @override
  Future<ResultsModel> getVehicleTypes() async {
    final response = await client.get(
        'https://unsplash.com/napi/photos/Q14J2k8VE3U/related',
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return ResultsModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
