part of 'cancel_order_bloc.dart';

abstract class CancelOrderState extends Equatable {
  const CancelOrderState();

  @override
  List<Object> get props => [];
}

class CancelOrderInitial extends CancelOrderState {}

class CancelOrderLoading extends CancelOrderState {}

class CancelOrderError extends CancelOrderState {
  final String message;
  const CancelOrderError(this.message);

  @override
  List<Object> get props => [message];
}

class CancelOrderSuccess extends CancelOrderState {
  final BaseEntity entity;
  const CancelOrderSuccess(this.entity);

  @override
  List<Object> get props => [entity];
}
