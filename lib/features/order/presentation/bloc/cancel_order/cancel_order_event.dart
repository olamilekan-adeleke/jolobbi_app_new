part of 'cancel_order_bloc.dart';

class CancelOrderEvent extends Equatable {
  final CancelOrderStatusParams params;
  const CancelOrderEvent(this.params);

  @override
  List<Object> get props => [params];
}
