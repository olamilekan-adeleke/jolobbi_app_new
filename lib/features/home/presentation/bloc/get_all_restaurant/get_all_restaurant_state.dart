part of 'get_all_restaurant_bloc.dart';

abstract class GetAllRestaurantState extends Equatable {
  const GetAllRestaurantState();
  
  @override
  List<Object> get props => [];
}

class GetAllRestaurantInitial extends GetAllRestaurantState {}

class GetAllRestaurantLoading extends GetAllRestaurantState {}

class GetAllRestaurantLoadingMore extends GetAllRestaurantState {}

class GetAllRestaurantSuccess extends GetAllRestaurantState {
  final List<ShopDetailsEntity> shops;

  const GetAllRestaurantSuccess(this.shops);

  @override
  List<Object> get props => [shops];
}

class GetAllRestaurantError extends GetAllRestaurantState {
  final String message;

  const GetAllRestaurantError(this.message);

  @override
  List<Object> get props => [message];
}

class GetAllRestaurantErrorMore extends GetAllRestaurantState {
  final String message;

  const GetAllRestaurantErrorMore(this.message);

  @override
  List<Object> get props => [message];
}
