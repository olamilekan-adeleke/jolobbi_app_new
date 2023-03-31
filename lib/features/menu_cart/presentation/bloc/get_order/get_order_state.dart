part of 'get_order_bloc.dart';

abstract class GetOrderState extends Equatable {
  const GetOrderState();

  @override
  List<Object> get props => [];
}

class GetOrderInitial extends GetOrderState {}

class GetOrderLoading extends GetOrderState {}

class GetOrderLoadingMore extends GetOrderState {}

class GetOrderError extends GetOrderState {
  final String message;
  const GetOrderError(this.message);

  @override
  List<Object> get props => [message];
}

class GetOrderErrorMore extends GetOrderState {
  final String message;
  const GetOrderErrorMore(this.message);

  @override
  List<Object> get props => [message];
}

class GetOrderSuccess extends GetOrderState {
  final List<OrderEntity> orders;
  const GetOrderSuccess(this.orders);

  @override
  List<Object> get props => [orders];
}
