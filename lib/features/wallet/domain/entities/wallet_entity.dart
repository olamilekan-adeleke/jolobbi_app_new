import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  const WalletEntity({
    required this.userId,
    required this.balance,
    required this.lastBalance,
    required this.lastDeposit,
    required this.lastWithdrawal,
    required this.active,
  });

  final String userId;
  final num balance;
  final num lastBalance;
  final num lastDeposit;
  final num lastWithdrawal;
  final bool active;

  @override
  List<Object?> get props =>
      [userId, balance, lastBalance, lastDeposit, lastWithdrawal, active];
}
