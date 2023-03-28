part of 'withdrawal_bloc.dart';

abstract class WithdrawalState extends Equatable {
  const WithdrawalState();

  @override
  List<Object> get props => [];
}

class WithdrawalInitial extends WithdrawalState {}

class WithdrawalLoading extends WithdrawalState {}

class WithdrawalError extends WithdrawalState {
  final String message;
  const WithdrawalError(this.message);

  @override
  List<Object> get props => [message];
}

class WithdrawalSuccess extends WithdrawalState {
  final BaseEntity entity;
  const WithdrawalSuccess(this.entity);

  @override
  List<Object> get props => [entity];
}
