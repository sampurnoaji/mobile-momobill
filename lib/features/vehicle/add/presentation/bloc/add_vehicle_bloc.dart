import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:momobill/core/usecase/usecase.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_type.dart';
import 'package:momobill/features/vehicle/add/domain/usecases/get_vehicle_types_usecase.dart';
import 'package:momobill/features/vehicle/add/presentation/models/vehicle_brand_validation.dart';
import 'package:momobill/features/vehicle/add/presentation/models/vehicle_manufacture_validation.dart';
import 'package:momobill/features/vehicle/add/presentation/models/vehicle_type_validation.dart';

part 'add_vehicle_event.dart';
part 'add_vehicle_state.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
  final GetVehicleTypesUseCase getVehicleTypesUseCase;

  AddVehicleBloc({GetVehicleTypesUseCase getVehicleTypesUseCase})
      : this.getVehicleTypesUseCase = getVehicleTypesUseCase,
        super(AddVehicleInitial());

  @override
  Stream<AddVehicleState> mapEventToState(AddVehicleEvent event) async* {
    if (event is AddVehicle) {
      yield _mapAddVehicleToState(event);
    } else if (event is GetVehicleTypes) {
      yield* _mapGetVehicleTypesToState();
    }
  }

  _mapAddVehicleToState(AddVehicle event) {
    final vehicleType = VehicleTypeValidation.dirty(event.type ?? '');
    final vehicleBrand = VehicleBrandValidation.dirty(event.brand ?? '');
    final vehicleManufacture =
        VehicleManufactureValidation.dirty(event.manufacture ?? '');

    if (vehicleType.invalid)
      return AddVehicleFailure(message: 'Lengkapi isian tipe kedaraan');
    else if (vehicleBrand.invalid)
      return AddVehicleFailure(message: 'Lengkapi isian brand kedaraan');
    else if (vehicleManufacture.invalid)
      return AddVehicleFailure(message: 'Lengkapi isian manufaktur kedaraan');
    else
      return AddVehicleSuccess();
  }

  Stream<AddVehicleState> _mapGetVehicleTypesToState() async* {
    try {
      final result = await getVehicleTypesUseCase(NoParams());
      yield result.fold(
            (l) => GetVehicleTypesFailure(),
            (r) => GetVehicleTypesSuccess(vehicleTypes: r));
    } catch (_) {
      yield GetVehicleTypesFailure();
    }
  }
}
