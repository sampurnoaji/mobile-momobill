import 'package:equatable/equatable.dart';

class VehicleType extends Equatable {
  final int id;
  final String name;

  VehicleType({this.id, this.name});

  @override
  List<Object> get props => [id, name];
}