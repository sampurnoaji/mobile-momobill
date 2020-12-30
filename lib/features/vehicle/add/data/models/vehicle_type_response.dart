import 'package:momobill/features/vehicle/add/domain/models/vehicle_type.dart';

class VehicleTypeListResponse extends VehicleType{
  final List<VehicleTypeResponse> vehicleTypes;

  VehicleTypeListResponse({this.vehicleTypes});

  factory VehicleTypeListResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<VehicleTypeResponse> vehicleTypes =
        list.map((e) => VehicleTypeResponse.fromJson(e)).toList();
    return VehicleTypeListResponse(vehicleTypes: vehicleTypes);
  }
}

class VehicleTypeResponse {
  final String id;
  final String name;

  VehicleTypeResponse({this.id, this.name});

  factory VehicleTypeResponse.fromJson(Map<String, dynamic> json) {
    return VehicleTypeResponse(id: json['id'], name: json['description']);
  }
}

extension ResultsModelExtension on VehicleTypeListResponse {
  get toDomainModel {
    List<VehicleType> vehicleTypes = [];
    this.vehicleTypes.forEach((element) {
      vehicleTypes.add(VehicleType(id: element.id, name: element.name));
    });
    return vehicleTypes;
  }
}
