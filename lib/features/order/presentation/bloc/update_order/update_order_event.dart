part of 'update_order_bloc.dart';

 class UpdateOrderEvent extends Equatable {
  final UpdateOrderStatusParams params;
  const UpdateOrderEvent(this.params);

  @override
  List<Object> get props => [params];
}

