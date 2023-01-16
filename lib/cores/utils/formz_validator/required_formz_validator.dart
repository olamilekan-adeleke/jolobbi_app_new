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
