import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class VehicleModel extends Equatable {
  final int id;
  final int brandId;
  final String name;

  VehicleModel({@required this.id, @required this.brandId, @required this.name});

  @override
  List<Object> get props => [id, brandId, name];
}
