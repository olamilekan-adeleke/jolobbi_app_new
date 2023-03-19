part of 'get_restaurant_drink_item_bloc.dart';

abstract class GetRestaurantDrinkItemState extends Equatable {
  const GetRestaurantDrinkItemState();

  @override
  List<Object> get props => [];
}

class GetRestaurantDrinkItemInitial extends GetRestaurantDrinkItemState {}

class GetRestaurantDrinkItemLoading extends GetRestaurantDrinkItemState {}

class GetRestaurantDrinkItemLoadingMore extends GetRestaurantDrinkItemState {}

class GetRestaurantDrinkItemError extends GetRestaurantDrinkItemState {
  final String message;

  const GetRestaurantDrinkItemError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetRestaurantDrinkItemErrorMore extends GetRestaurantDrinkItemState {
  final String message;

  const GetRestaurantDrinkItemErrorMore({required this.message});

  @override
  List<Object> get props => [message];
}

class GetRestaurantDrinkItemSuccess extends GetRestaurantDrinkItemState {
  final List<MenuItemEntity> menuItemEntities;

  const GetRestaurantDrinkItemSuccess(this.menuItemEntities);

  @override
  List<Object> get props => [menuItemEntities];
}
