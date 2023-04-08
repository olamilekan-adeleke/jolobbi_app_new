part of 'withdrawal_bloc.dart';

class WithdrawalEvent extends Equatable {
  final Map<String, dynamic> data;
  const WithdrawalEvent(this.data);

  @override
  List<Object> get props => [data];
}
