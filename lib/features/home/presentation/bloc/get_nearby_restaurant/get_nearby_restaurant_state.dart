part of 'get_nearby_restaurant_bloc.dart';

abstract class GetNearbyRestaurantState extends Equatable {
  const GetNearbyRestaurantState();

  @override
  List<Object> get props => [];
}

class GetNearbyRestaurantInitial extends GetNearbyRestaurantState {}

class GetNearbyRestaurantLoading extends GetNearbyRestaurantState {}

class GetNearbyRestaurantError extends GetNearbyRestaurantState {
  final String message;

  const GetNearbyRestaurantError(this.message);

  @override
  List<Object> get props => [message];
}

class GetNearbyRestaurantSuccess extends GetNearbyRestaurantState {
  final List<ShopDetailsEntity> shops;

  const GetNearbyRestaurantSuccess(this.shops);
}
