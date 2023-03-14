part of 'get_popular_restaurant_bloc.dart';

abstract class GetPopularRestaurantState extends Equatable {
  const GetPopularRestaurantState();

  @override
  List<Object> get props => [];
}

class GetPopularRestaurantInitial extends GetPopularRestaurantState {}

class GetPopularRestaurantLoading extends GetPopularRestaurantState {}

class GetPopularRestaurantLoadingMore extends GetPopularRestaurantState {}

class GetPopularRestaurantError extends GetPopularRestaurantState {
  final String message;

  const GetPopularRestaurantError(this.message);

  @override
  List<Object> get props => [message];
}

class GetPopularRestaurantMoreError extends GetPopularRestaurantState {
  final String message;

  const GetPopularRestaurantMoreError(this.message);

  @override
  List<Object> get props => [message];
}


class GetPopularRestaurantSuccess extends GetPopularRestaurantState {
  final List<ShopDetailsEntity> shops;

  const GetPopularRestaurantSuccess(this.shops);
}
