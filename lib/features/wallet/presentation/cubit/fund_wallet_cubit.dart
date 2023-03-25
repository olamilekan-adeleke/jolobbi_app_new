import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../cores/utils/formz_validator/payment_option.dart';
import '../../../../cores/utils/formz_validator/required_formz_validator.dart';

class FundWalletCubit extends Cubit<FundWalletFormz> {
  FundWalletCubit() : super(FundWalletFormz());

  void amountChanged(String value) {
    final num amount =
        num.tryParse(value.replaceAll("\u20A6", "").replaceAll(',', "")) ?? 0;
    emit(state.copyWith(amount: RequiredInt.dirty(amount.toInt())));
  }

  void paymentOptionChanged(PaymentOption value) {
    emit(state.copyWith(paymentOption: RequiredPaymentOption.dirty(value)));
  }

  void reset() => emit(FundWalletFormz());
}

class FundWalletFormz extends Equatable with FormzMixin {
  final RequiredInt amount;
  final RequiredPaymentOption paymentOption;

  FundWalletFormz({
    this.amount = const RequiredInt.pure(0),
    this.paymentOption = const RequiredPaymentOption.pure(),
  });

  PaymentOption get getOption => paymentOption.value;

  bool get isValid => status == FormzStatus.valid;

  @override
  List<FormzInput> get inputs => [amount, paymentOption];

  FundWalletFormz copyWith({
    RequiredInt? amount,
    RequiredPaymentOption? paymentOption,
  }) {
    return FundWalletFormz(
      amount: amount ?? this.amount,
      paymentOption: paymentOption ?? this.paymentOption,
    );
  }

  @override
  List<Object?> get props => [amount, paymentOption];
}
