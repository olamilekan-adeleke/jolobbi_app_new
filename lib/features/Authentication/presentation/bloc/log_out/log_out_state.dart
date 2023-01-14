part of 'log_out_bloc.dart';

abstract class LogOutState extends Equatable {
  const LogOutState();

  @override
  List<Object> get props => [];
}

class LogOutInitial extends LogOutState {}

class LogOutLoading extends LogOutState {}

class LogOutError extends LogOutState {
  final String message;

  const LogOutError(this.message);
}

class LogOutSuccess extends LogOutState {}
