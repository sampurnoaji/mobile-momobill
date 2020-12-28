part of 'add_vehicle_bloc.dart';

abstract class AddVehicleEvent extends Equatable {
  const AddVehicleEvent();

  @override
  List<Object> get props => [];
}

class GetVehicleTypes extends AddVehicleEvent {}

class GetVehicleBrands extends AddVehicleEvent {}

class GetVehicleModels extends AddVehicleEvent {}

class VehicleTypeChanged extends AddVehicleEvent {
  const VehicleTypeChanged(this.type);

  final String type;

  @override
  List<Object> get props => [type];
}

class VehicleBrandChanged extends AddVehicleEvent {
  final String brand;

  VehicleBrandChanged(this.brand);

  @override
  List<Object> get props => [brand];
}

class VehicleManufactureChanged extends AddVehicleEvent {
  final String manufacture;

  VehicleManufactureChanged(this.manufacture);

  @override
  List<Object> get props => [manufacture];
}

class AddVehicle extends AddVehicleEvent {
  final String type, brand, manufacture;

  AddVehicle(this.type, this.brand, this.manufacture);
}
