part of 'get_all_restaurant_bloc.dart';

class GetAllRestaurantEvent extends Equatable {
  final bool getFreshData;
  const GetAllRestaurantEvent([this.getFreshData = true]);

  @override
  List<Object> get props => [];
}
