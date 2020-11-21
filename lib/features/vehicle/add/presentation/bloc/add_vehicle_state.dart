part of 'add_vehicle_bloc.dart';

abstract class AddVehicleState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddVehicleInitial extends AddVehicleState {}

class AddVehicleLoading extends AddVehicleState {}

class AddVehicleSuccess extends AddVehicleState {}

class AddVehicleFailure extends AddVehicleState {
  final String message;

  AddVehicleFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
