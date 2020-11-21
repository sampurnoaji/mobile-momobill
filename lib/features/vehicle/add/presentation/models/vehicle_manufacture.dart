import 'package:formz/formz.dart';

enum VehicleManufactureValidationError { empty }

class VehicleManufacture extends FormzInput<String, VehicleManufactureValidationError> {
  const VehicleManufacture.pure() : super.pure('');
  const VehicleManufacture.dirty([String value = '']) : super.dirty(value);

  @override
  VehicleManufactureValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : VehicleManufactureValidationError.empty;
  }
}