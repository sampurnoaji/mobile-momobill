import 'package:formz/formz.dart';

enum VehicleManufactureValidationError { empty }

class VehicleManufactureValidation extends FormzInput<String, VehicleManufactureValidationError> {
  const VehicleManufactureValidation.pure() : super.pure('');
  const VehicleManufactureValidation.dirty([String value = '']) : super.dirty(value);

  @override
  VehicleManufactureValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : VehicleManufactureValidationError.empty;
  }
}