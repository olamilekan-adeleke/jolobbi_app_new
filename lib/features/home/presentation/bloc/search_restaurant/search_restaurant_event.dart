part of 'search_restaurant_bloc.dart';

class SearchRestaurantEvent extends Equatable {
  final String query;

  const SearchRestaurantEvent(this.query);

  @override
  List<Object> get props => [query];
}
