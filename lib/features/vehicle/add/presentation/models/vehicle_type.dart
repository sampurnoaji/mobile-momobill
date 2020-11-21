import 'package:formz/formz.dart';

enum VehicleTypeValidationError { empty }

class VehicleType extends FormzInput<String, VehicleTypeValidationError> {
  const VehicleType.pure() : super.pure('');
  const VehicleType.dirty([String value = '']) : super.dirty(value);

  @override
  VehicleTypeValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : VehicleTypeValidationError.empty;
  }
}