part of 'get_transaction_bloc.dart';

class GetTransactionEvent extends Equatable {
  final bool getFreshData;
  const GetTransactionEvent([this.getFreshData = true]);

  @override
  List<Object> get props => [getFreshData];
}
