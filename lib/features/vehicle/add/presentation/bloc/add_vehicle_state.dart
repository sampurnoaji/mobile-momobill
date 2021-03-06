part of 'add_vehicle_bloc.dart';

abstract class AddVehicleState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetVehicleTypesSuccess extends AddVehicleState {
  final List<VehicleType> vehicleTypes;

  GetVehicleTypesSuccess({this.vehicleTypes});

  @override
  List<Object> get props => [vehicleTypes];
}

class GetVehicleTypesFailure extends AddVehicleState {}

class GetVehicleBrandsSuccess extends AddVehicleState {
  final List<VehicleBrand> vehicleBrands;

  GetVehicleBrandsSuccess({this.vehicleBrands});

  @override
  List<Object> get props => [vehicleBrands];
}

class GetVehicleBrandsFailure extends AddVehicleState {}

class GetVehicleModelsSuccess extends AddVehicleState {
  final List<VehicleModel> vehicleModels;

  GetVehicleModelsSuccess(this.vehicleModels);

  @override
  List<Object> get props => [vehicleModels];
}

class GetVehicleModelsFailure extends AddVehicleState {}

class AddVehicleInitial extends AddVehicleState {}

class AddVehicleLoading extends AddVehicleState {}

class AddVehicleSuccess extends AddVehicleState {}

class AddVehicleFailure extends AddVehicleState {
  final String message;

  AddVehicleFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
