part of 'create_order_bloc.dart';

abstract class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderLoading extends CreateOrderState {}

class CreateOrderError extends CreateOrderState {
  final String message;
  const CreateOrderError(this.message);

  @override
  List<Object> get props => [message];
}

class CreateOrderSuccess extends CreateOrderState {
  final BaseEntity baseEntity;
  const CreateOrderSuccess(this.baseEntity);

  @override
  List<Object> get props => [baseEntity];
}
