// import 'package:formz/formz.dart';

// enum PhoneValidationError { invalid }

// class Phone extends FormzInput<String, PhoneValidationError> {
//   const Phone.pure([String value = '']) : super.pure(value);
//   const Phone.dirty([String value = '']) : super.dirty(value);

//   static final _phoneRegExp = RegExp(
//     r'^(?=.{5,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$',
//   );

//   @override
//   PhoneValidationError? validator(String value) {
//     if (value.isNotEmpty) {
//       return null;
//     } else {
//       return PhoneValidationError.invalid;
//     }
//   }
// }

// extension on PhoneValidationError {
//   String text() {
//     switch (this) {
//       case PhoneValidationError.invalid:
//         return '''Phone must be at least 3 characters''';
//     }
//   }
// }
