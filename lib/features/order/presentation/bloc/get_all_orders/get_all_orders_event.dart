part of 'get_all_orders_bloc.dart';

class GetAllOrdersEvent extends Equatable {
  final bool getFreshData;
  const GetAllOrdersEvent([this.getFreshData = true]);

  @override
  List<Object> get props => [getFreshData];
}
