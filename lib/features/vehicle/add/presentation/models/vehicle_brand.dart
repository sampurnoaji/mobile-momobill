import 'package:formz/formz.dart';

enum VehicleBrandValidationError { empty }

class VehicleBrand extends FormzInput<String, VehicleBrandValidationError> {
  const VehicleBrand.pure() : super.pure('');
  const VehicleBrand.dirty([String value = '']) : super.dirty(value);

  @override
  VehicleBrandValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : VehicleBrandValidationError.empty;
  }
}