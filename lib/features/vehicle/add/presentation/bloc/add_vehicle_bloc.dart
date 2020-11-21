import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:momobill/features/vehicle/add/presentation/models/vehicle_brand.dart';
import 'package:momobill/features/vehicle/add/presentation/models/vehicle_manufacture.dart';
import 'package:momobill/features/vehicle/add/presentation/models/vehicle_type.dart';

part 'add_vehicle_event.dart';
part 'add_vehicle_state.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
  AddVehicleBloc() : super(AddVehicleInitial());

  @override
  Stream<AddVehicleState> mapEventToState(AddVehicleEvent event) async* {
    yield AddVehicleLoading();

    if (event is AddVehicle) {
      yield _mapAddVehicleToState(event);
    }
  }

  _mapAddVehicleToState(AddVehicle event) {
    final vehicleType = VehicleType.dirty(event.type ?? '');
    final vehicleBrand = VehicleBrand.dirty(event.brand ?? '');
    final vehicleManufacture = VehicleManufacture.dirty(event.manufacture ?? '');

    if (vehicleType.invalid) return AddVehicleFailure(message: 'Lengkapi isian tipe kedaraan');
    else if (vehicleBrand.invalid) return AddVehicleFailure(message: 'Lengkapi isian brand kedaraan');
    else if (vehicleManufacture.invalid) return AddVehicleFailure(message: 'Lengkapi isian manufaktur kedaraan');
    else return AddVehicleSuccess();
  }
}
