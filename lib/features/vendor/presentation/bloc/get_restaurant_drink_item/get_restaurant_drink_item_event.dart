part of 'get_restaurant_drink_item_bloc.dart';

class GetRestaurantDrinkItemEvent extends Equatable {
  final String id;
  final bool shouldGetFreshData;

  const GetRestaurantDrinkItemEvent(this.id, {this.shouldGetFreshData = true});

  @override
  List<Object> get props => [id, shouldGetFreshData];
}
