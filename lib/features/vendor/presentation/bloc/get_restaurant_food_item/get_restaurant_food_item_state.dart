part of 'get_restaurant_food_item_bloc.dart';

abstract class GetRestaurantFoodItemState extends Equatable {
  const GetRestaurantFoodItemState();

  @override
  List<Object> get props => [];
}

class GetRestaurantFoodItemInitial extends GetRestaurantFoodItemState {}

class GetRestaurantFoodItemLoading extends GetRestaurantFoodItemState {}

class GetRestaurantFoodItemLoadingMore extends GetRestaurantFoodItemState {}

class GetRestaurantFoodItemError extends GetRestaurantFoodItemState {
  final String message;

  const GetRestaurantFoodItemError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetRestaurantFoodItemErrorMore extends GetRestaurantFoodItemState {
  final String message;

  const GetRestaurantFoodItemErrorMore({required this.message});

  @override
  List<Object> get props => [message];
}

class GetRestaurantFoodItemSuccess extends GetRestaurantFoodItemState {
  final List<MenuItemEntity> menuItemEntities;

  const GetRestaurantFoodItemSuccess(this.menuItemEntities);

  @override
  List<Object> get props => [menuItemEntities];
}
