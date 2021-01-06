import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class VehicleBrand extends Equatable {
  final int id;
  final int typeId;
  final String name;

  VehicleBrand({@required this.id, @required this.typeId, @required this.name});

  @override
  List<Object> get props => [id, typeId, name];
}
