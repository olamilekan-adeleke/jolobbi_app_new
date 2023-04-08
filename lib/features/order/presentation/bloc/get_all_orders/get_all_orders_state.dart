part of 'get_all_orders_bloc.dart';

abstract class GetAllOrdersState extends Equatable {
  const GetAllOrdersState();

  @override
  List<Object> get props => [];
}

class GetAllOrdersInitial extends GetAllOrdersState {}

class GetAllOrdersLoading extends GetAllOrdersState {}

class GetAllOrdersLoadingMore extends GetAllOrdersState {}

class GetAllOrdersSuccess extends GetAllOrdersState {
  final List<OrderEntity> orders;
  const GetAllOrdersSuccess(this.orders);

  @override
  List<Object> get props => [orders];
}

class GetAllOrdersError extends GetAllOrdersState {
  final String message;
  const GetAllOrdersError(this.message);

  @override
  List<Object> get props => [message];
}

class GetAllOrdersErrorMore extends GetAllOrdersState {
  final String message;
  const GetAllOrdersErrorMore(this.message);

  @override
  List<Object> get props => [message];
}
