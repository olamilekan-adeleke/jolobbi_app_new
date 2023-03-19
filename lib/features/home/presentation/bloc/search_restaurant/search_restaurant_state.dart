part of 'search_restaurant_bloc.dart';

abstract class SearchRestaurantState extends Equatable {
  const SearchRestaurantState();

  @override
  List<Object> get props => [];
}

class SearchRestaurantInitial extends SearchRestaurantState {}

class SearchRestaurantLoading extends SearchRestaurantState {}

class SearchRestaurantSuccess extends SearchRestaurantState {
  final List<ShopDetailsEntity> shops;

  const SearchRestaurantSuccess(this.shops);

  @override
  List<Object> get props => [shops];
}

class SearchRestaurantError extends SearchRestaurantState {
  final String message;

  const SearchRestaurantError(this.message);

  @override
  List<Object> get props => [message];
}
