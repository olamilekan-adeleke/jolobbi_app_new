import 'package:formz/formz.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure([String value = '']) : super.pure(value);
  const Username.dirty([String value = '']) : super.dirty(value);

   static final _usernameRegExp = RegExp(
    r'^(?=.{5,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$',
  );

  @override
  UsernameValidationError? validator(String value) {
    if (_usernameRegExp.hasMatch(value)) {
      return null;
    } else {
      return UsernameValidationError.invalid;
    }
  }
}

extension on UsernameValidationError {
  String text() {
    switch (this) {
      case UsernameValidationError.invalid:
        return '''Username must be at least 5 characters, Not start or end with underscore or dot, Not contain two consecutive underscore or dot, Not contain special characters ''';
    }
  }
}
