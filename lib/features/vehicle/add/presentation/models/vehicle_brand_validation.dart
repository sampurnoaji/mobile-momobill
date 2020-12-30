import 'package:formz/formz.dart';

enum VehicleBrandValidationError { empty }

class VehicleBrandValidation extends FormzInput<String, VehicleBrandValidationError> {
  const VehicleBrandValidation.pure() : super.pure('');
  const VehicleBrandValidation.dirty([String value = '']) : super.dirty(value);

  @override
  VehicleBrandValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : VehicleBrandValidationError.empty;
  }
}