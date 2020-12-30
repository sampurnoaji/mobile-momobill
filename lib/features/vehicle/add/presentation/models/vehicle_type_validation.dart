import 'package:formz/formz.dart';

enum VehicleTypeValidationError { empty }

class VehicleTypeValidation extends FormzInput<String, VehicleTypeValidationError> {
  const VehicleTypeValidation.pure() : super.pure('');
  const VehicleTypeValidation.dirty([String value = '']) : super.dirty(value);

  @override
  VehicleTypeValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : VehicleTypeValidationError.empty;
  }
}