import 'package:flutter/cupertino.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_model.dart';

class VehicleModelListResponse extends VehicleModel {
  final List<VehicleModelResponse> vehicleModels;

  VehicleModelListResponse({this.vehicleModels});

  factory VehicleModelListResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<VehicleModelResponse> vehicleModels =
        list.map((e) => VehicleModelResponse.fromJson(e)).toList();
    return VehicleModelListResponse(vehicleModels: vehicleModels);
  }
}

class VehicleModelResponse {
  final int id;
  final int brandId;
  final String name;

  VehicleModelResponse(
      {@required this.id, @required this.brandId, @required this.name});

  factory VehicleModelResponse.fromJson(Map<String, dynamic> json) {
    return VehicleModelResponse(
        id: json['width'], brandId: json['height'], name: json['description']);
  }
}

extension ResultsModelExtension on VehicleModelListResponse {
  get toDomainModel {
    List<VehicleModel> vehicleModels = [];
    this.vehicleModels.forEach((element) {
      vehicleModels.add(
          VehicleModel(id: element.id, brandId: element.id, name: element.name));
    });
    return vehicleModels;
  }
}
