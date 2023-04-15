import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../cores/utils/formz_validator/required_formz_validator.dart';

class WithdrawalCubit extends Cubit<WithdrawalStateFormz> {
  WithdrawalCubit() : super(const WithdrawalStateFormz());

  void reset() => emit(const WithdrawalStateFormz());

  void accountNumberChanged(String value) {
    emit(state.copyWith(accountNumber: Required.dirty(value)));
  }

  void bankNameChanged(String value) {
    emit(state.copyWith(bankName: Required.dirty(value)));
  }

  void accountNameChanged(String value) {
    emit(state.copyWith(accountName: Required.dirty(value)));
  }

  void amountChanged(String value) {
    final int amount = int.tryParse(value) ?? 0;
    emit(state.copyWith(amount: RequiredInt.dirty(amount)));
  }
}

class WithdrawalStateFormz with FormzMixin {
  final Required accountNumber;
  final Required bankName;
  final Required accountName;
  final RequiredInt amount;

  const WithdrawalStateFormz({
    this.accountNumber = const Required.pure(),
    this.bankName = const Required.pure(),
    this.accountName = const Required.pure(),
    this.amount = const RequiredInt.pure(),
  });

  bool get isValid {
    return accountNumber.value.length == 11 &&
        bankName.valid &&
        accountName.valid &&
        amount.valid;
  }

  WithdrawalStateFormz copyWith({
    Required? accountNumber,
    Required? bankName,
    Required? accountName,
    RequiredInt? amount,
  }) {
    return WithdrawalStateFormz(
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<FormzInput> get inputs => [accountNumber, bankName, accountName, amount];

  Map<String, dynamic> toMap() {
    return {
      'account_number': accountNumber.value,
      'bank_name': bankName.value,
      'account_name': accountName.value,
      'amount': amount.value,
    };
  }
}
