import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.userId,
    required super.transactionType,
    required super.amount,
    required super.description,
    required super.date,
    required super.status,
    required super.action,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> json) {
    return TransactionModel(
      id: json["id"],
      userId: json["userId"],
      transactionType: transactionTypeValues[json["transactionType"]] ??
          TransactionType.debit,
      amount: json["amount"],
      description: json["description"],
      date: (json["date"] as Timestamp).toDate(),
      status:
          transactionStatusValues[json["status"]] ?? TransactionStatus.pending,
      action: transactionActionValues[json["action"]] ?? TransactionAction.none,
    );
  }
}

enum TransactionType { debit, credit }

const Map<String, TransactionType> transactionTypeValues = {
  "debit": TransactionType.debit,
  "credit": TransactionType.credit,
};

enum TransactionStatus { pending, completed, failed }

const Map<String, TransactionStatus> transactionStatusValues = {
  "pending": TransactionStatus.pending,
  "completed": TransactionStatus.completed,
  "failed": TransactionStatus.failed,
};

enum TransactionAction {
  fundWallet,
  payment,
  withdrawal,
  refund,
  acceptPayment,
  none
}

const Map<String, TransactionAction> transactionActionValues = {
  "fund_wallet": TransactionAction.fundWallet,
  "payment": TransactionAction.payment,
  "withdrawal": TransactionAction.withdrawal,
  "refund": TransactionAction.refund,
  "accept_payment": TransactionAction.acceptPayment,
  "none": TransactionAction.none,
};
