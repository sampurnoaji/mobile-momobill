import 'package:flutter/cupertino.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_brand.dart';

class VehicleBrandListResponse extends VehicleBrand {
  final List<VehicleBrandResponse> vehicleBrands;

  VehicleBrandListResponse({this.vehicleBrands});

  factory VehicleBrandListResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<VehicleBrandResponse> vehicleBrands =
        list.map((e) => VehicleBrandResponse.fromJson(e)).toList();
    return VehicleBrandListResponse(vehicleBrands: vehicleBrands);
  }
}

class VehicleBrandResponse {
  final int id;
  final int typeId;
  final String name;

  VehicleBrandResponse(
      {@required this.id, @required this.typeId, @required this.name});

  factory VehicleBrandResponse.fromJson(Map<String, dynamic> json) {
    return VehicleBrandResponse(
        id: json['width'], typeId: json['height'], name: json['description']);
  }
}

extension ResultsModelExtension on VehicleBrandListResponse {
  get toDomainModel {
    List<VehicleBrand> vehicleBrands = [];
    this.vehicleBrands.forEach((element) {
      vehicleBrands.add(
          VehicleBrand(id: element.id, typeId: element.id, name: element.name));
    });
    return vehicleBrands;
  }
}
