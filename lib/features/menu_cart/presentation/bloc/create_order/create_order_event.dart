part of 'create_order_bloc.dart';

class CreateOrderEvent extends Equatable {
  final OrderFormzModel order;
  const CreateOrderEvent(this.order);

  @override
  List<Object> get props => [order];
}
