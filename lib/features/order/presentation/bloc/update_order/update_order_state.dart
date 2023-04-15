part of 'update_order_bloc.dart';

abstract class UpdateOrderState extends Equatable {
  const UpdateOrderState();

  @override
  List<Object> get props => [];
}

class UpdateOrderInitial extends UpdateOrderState {}

class UpdateOrderLoading extends UpdateOrderState {}

class UpdateOrderSuccess extends UpdateOrderState {
  final BaseEntity entity;
  const UpdateOrderSuccess(this.entity);

  @override
  List<Object> get props => [entity];
}

class UpdateOrderError extends UpdateOrderState {
  final String message;
  const UpdateOrderError(this.message);

  @override
  List<Object> get props => [message];
}
