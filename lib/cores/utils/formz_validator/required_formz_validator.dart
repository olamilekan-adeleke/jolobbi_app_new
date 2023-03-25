import 'package:formz/formz.dart';

enum RequiredValidationError { invalid }

class Required extends FormzInput<String, RequiredValidationError> {
  const Required.pure([String value = '']) : super.pure(value);
  const Required.dirty([String value = '']) : super.dirty(value);

  @override
  RequiredValidationError? validator(String value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return RequiredValidationError.invalid;
    }
  }
}

class RequiredDouble extends FormzInput<double, RequiredValidationError> {
  const RequiredDouble.pure([double value = 0]) : super.pure(value);
  const RequiredDouble.dirty([double value = 0]) : super.dirty(value);

  @override
  RequiredValidationError? validator(double value) {
    if (value != 0) {
      return null;
    } else {
      return RequiredValidationError.invalid;
    }
  }
}

class RequiredInt extends FormzInput<int, RequiredValidationError> {
  const RequiredInt.pure([int value = 0]) : super.pure(value);
  const RequiredInt.dirty([int value = 0]) : super.dirty(value);

  @override
  RequiredValidationError? validator(int value) {
    if (value != 0) {
      return null;
    } else {
      return RequiredValidationError.invalid;
    }
  }
}
