import 'package:formz/formz.dart';

enum PaymentOption { flutterWave, paystack, none }

enum RequiredValidationError { invalid }

class RequiredPaymentOption extends FormzInput<PaymentOption, RequiredValidationError> {
  const RequiredPaymentOption.pure([PaymentOption value = PaymentOption.none])
      : super.pure(value);
  const RequiredPaymentOption.dirty([PaymentOption value = PaymentOption.none])
      : super.dirty(value);

  @override
  RequiredValidationError? validator(PaymentOption value) {
    if (value != PaymentOption.none) {
      return null;
    } else {
      return RequiredValidationError.invalid;
    }
  }
}
