part of 'get_transaction_bloc.dart';

abstract class GetTransactionState extends Equatable {
  const GetTransactionState();

  @override
  List<Object> get props => [];
}

class GetTransactionInitial extends GetTransactionState {}

class GetTransactionLoading extends GetTransactionState {}

class GetTransactionLoadingMore extends GetTransactionState {}

class GetTransactionError extends GetTransactionState {
  final String message;
  const GetTransactionError(this.message);

  @override
  List<Object> get props => [message];
}

class GetTransactionErrorMore extends GetTransactionState {
  final String message;
  const GetTransactionErrorMore(this.message);

  @override
  List<Object> get props => [message];
}

class GetTransactionSuccess extends GetTransactionState {
  final List<TransactionEntity> transactions;
  const GetTransactionSuccess(this.transactions);

  @override
  List<Object> get props => [transactions];
}
