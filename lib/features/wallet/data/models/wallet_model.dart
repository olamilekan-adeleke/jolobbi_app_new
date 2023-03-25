import '../../domain/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  const WalletModel({
    required super.userId,
    required super.balance,
    required super.lastBalance,
    required super.lastDeposit,
    required super.lastWithdrawal,
    required super.active,
  });

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      userId: map['userId'] ?? "",
      balance: map['balance'] ?? 0,
      lastBalance: map['lastBalance'] ?? 0,
      lastDeposit: map['lastDeposit'] ?? 0,
      lastWithdrawal: map['lastWithdrawal'] ?? 0,
      active: map['active'] ?? true,
    );
  }
}
