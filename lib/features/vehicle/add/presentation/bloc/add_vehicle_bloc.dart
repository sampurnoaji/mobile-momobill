import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:momobill/core/usecase/usecase.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_brand.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_model.dart';
import 'package:momobill/features/vehicle/add/domain/models/vehicle_type.dart';
import 'package:momobill/features/vehicle/add/domain/usecases/get_vehicle_brands_usecase.dart';
import 'package:momobill/features/vehicle/add/domain/usecases/get_vehicle_models_usecase.dart';
import 'package:momobill/features/vehicle/add/domain/usecases/get_vehicle_types_usecase.dart';
import 'package:momobill/features/vehicle/add/presentation/models/vehicle_brand_validation.dart';
import 'package:momobill/features/vehicle/add/presentation/models/vehicle_manufacture_validation.dart';
import 'package:momobill/features/vehicle/add/presentation/models/vehicle_type_validation.dart';

part 'add_vehicle_event.dart';
part 'add_vehicle_state.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
  final GetVehicleTypesUseCase getVehicleTypesUseCase;
  final GetVehicleBrandsUseCase getVehicleBrandsUseCase;
  final GetVehicleModelsUseCase getVehicleModelsUseCase;

  AddVehicleBloc(
      {@required GetVehicleTypesUseCase getVehicleTypesUseCase,
      @required GetVehicleBrandsUseCase getVehicleBrandsUseCase,
      @required GetVehicleModelsUseCase getVehicleModelsUseCase})
      : this.getVehicleTypesUseCase = getVehicleTypesUseCase,
        this.getVehicleBrandsUseCase = getVehicleBrandsUseCase,
        this.getVehicleModelsUseCase = getVehicleModelsUseCase,
        super(AddVehicleInitial());

  @override
  Stream<AddVehicleState> mapEventToState(AddVehicleEvent event) async* {
    if (event is AddVehicle) {
      yield _mapAddVehicleToState(event);
    } else if (event is GetVehicleTypes) {
      yield* _mapGetVehicleTypesToState();
    } else if (event is GetVehicleBrands) {
      yield* _mapGetVehicleBrandsToState();
    } else if (event is GetVehicleModels) {
      yield* _mapGetVehicleModelsToState();
    }
  }

  _mapAddVehicleToState(AddVehicle event) {
    final vehicleType = VehicleTypeValidation.dirty(event.type ?? '');
    final vehicleBrand = VehicleBrandValidation.dirty(event.brand ?? '');
    final vehicleModel = VehicleManufactureValidation.dirty(event.model ?? '');

    if (vehicleType.invalid)
      return AddVehicleFailure(message: 'Lengkapi isian tipe kedaraan');
    else if (vehicleBrand.invalid)
      return AddVehicleFailure(message: 'Lengkapi isian merk kedaraan');
    else if (vehicleModel.invalid)
      return AddVehicleFailure(message: 'Lengkapi isian manufaktur kedaraan');
    else
      return AddVehicleSuccess();
  }

  Stream<AddVehicleState> _mapGetVehicleTypesToState() async* {
    try {
      final result = await getVehicleTypesUseCase(NoParams());
      yield result.fold((l) => GetVehicleTypesFailure(),
          (r) => GetVehicleTypesSuccess(vehicleTypes: r));
    } catch (_) {
      yield GetVehicleTypesFailure();
    }
  }

  Stream<AddVehicleState> _mapGetVehicleBrandsToState() async* {
    try {
      final result = await getVehicleBrandsUseCase(NoParams());
      yield result.fold((l) => GetVehicleBrandsFailure(),
          (r) => GetVehicleBrandsSuccess(vehicleBrands: r));
    } catch (_) {
      yield GetVehicleBrandsFailure();
    }
  }

  Stream<AddVehicleState> _mapGetVehicleModelsToState() async* {
    try {
      final result = await getVehicleModelsUseCase(NoParams());
      yield result.fold(
          (l) => GetVehicleModelsFailure(), (r) => GetVehicleModelsSuccess(r));
    } catch (_) {
      yield GetVehicleModelsFailure();
    }
  }
}
