part of 'get_order_by_id_bloc.dart';

abstract class GetOrderByIdState extends Equatable {
  const GetOrderByIdState();

  @override
  List<Object> get props => [];
}

class GetOrderByIdInitial extends GetOrderByIdState {}

class GetOrderByIdLoading extends GetOrderByIdState {}

class GetOrderByIdError extends GetOrderByIdState {
  final String message;
  const GetOrderByIdError(this.message);

  @override
  List<Object> get props => [message];
}

class GetOrderByIdSuccess extends GetOrderByIdState {
  final OrderEntity order;
  const GetOrderByIdSuccess(this.order);

  @override
  List<Object> get props => [order];
}
