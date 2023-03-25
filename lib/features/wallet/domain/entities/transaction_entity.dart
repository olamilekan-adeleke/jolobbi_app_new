import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/transaction_model.dart';

class TransactionEntity extends Equatable {
  const TransactionEntity({
    required this.id,
    required this.userId,
    required this.transactionType,
    required this.amount,
    required this.description,
    required this.date,
    required this.status,
    required this.action,
  });

  final String id;
  final String userId;
  final TransactionType transactionType;
  final num amount;
  final String description;
  final DateTime date;
  final TransactionStatus status;
  final TransactionAction action;

  String get sign => transactionType == TransactionType.credit ? "+" : "-";

  String get title {
    switch (action) {
      case TransactionAction.fundWallet:
        return "Fund Wallet";
      case TransactionAction.payment:
        return "Purchase";
      case TransactionAction.withdrawal:
        return "Withdrawal";
      case TransactionAction.refund:
        return "Refund";
      case TransactionAction.none:
        return "N/A";
    }
  }

  Color get color {
    switch (transactionType) {
      case TransactionType.credit:
        return Colors.green;
      case TransactionType.debit:
        return Colors.red;
    }
  }

  @override
  List<Object?> get props =>
      [id, userId, transactionType, amount, description, date, status, action];
}
