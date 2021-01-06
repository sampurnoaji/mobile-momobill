import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class VehicleType extends Equatable {
  final int id;
  final String name;

  VehicleType({@required this.id, @required this.name});

  @override
  List<Object> get props => [id, name];
}
