part of 'get_restaurant_food_item_bloc.dart';

class GetRestaurantFoodItemEvent extends Equatable {
  final String id;
  final bool shouldGetFreshData;

  const GetRestaurantFoodItemEvent(this.id, {this.shouldGetFreshData = true});

  @override
  List<Object> get props => [id];
}
