part of 'log_trans_bloc.dart';

abstract class LogTransState extends Equatable {
  const LogTransState();

  @override
  List<Object> get props => [];
}

class LogTransInitial extends LogTransState {}

class LogTransLoading extends LogTransState {}

class LogTransError extends LogTransState {
  final String message;
  const LogTransError(this.message);

  @override
  List<Object> get props => [message];
}

class LogTransSuccess extends LogTransState {
  final BaseEntity entity;
  const LogTransSuccess(this.entity);

  @override
  List<Object> get props => [entity];
}
