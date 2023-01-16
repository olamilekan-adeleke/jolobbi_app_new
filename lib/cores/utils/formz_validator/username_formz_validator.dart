import 'package:formz/formz.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure([String value = '']) : super.pure(value);
  const Username.dirty([String value = '']) : super.dirty(value);

  static final _usernameRegExp = RegExp(r'^[A-Za-z][A-Za-z0-9_]{3,29}$');

  @override
  UsernameValidationError? validator(String value) {
    if (_usernameRegExp.hasMatch(value)) {
      return null;
    } else {
      return UsernameValidationError.invalid;
    }
  }
}

