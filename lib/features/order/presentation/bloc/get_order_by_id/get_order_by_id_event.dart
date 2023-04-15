part of 'get_order_by_id_bloc.dart';

class GetOrderByIdEvent extends Equatable {
  final String id;
  const GetOrderByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}
