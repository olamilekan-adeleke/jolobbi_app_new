import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props =>
      [id, userId, transactionType, amount, description, date, status, action];
}
