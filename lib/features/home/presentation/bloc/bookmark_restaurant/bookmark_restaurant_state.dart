part of 'bookmark_restaurant_bloc.dart';

abstract class BookmarkRestaurantState extends Equatable {
  const BookmarkRestaurantState();

  @override
  List<Object> get props => [];
}

class BookmarkRestaurantInitial extends BookmarkRestaurantState {}

class BookmarkRestaurantLoading extends BookmarkRestaurantState {}

class BookmarkRestaurantError extends BookmarkRestaurantState {
  final String message;

  const BookmarkRestaurantError(this.message);

  @override
  List<Object> get props => [message];
}

class BookmarkRestaurantSuccess extends BookmarkRestaurantState {
  final BaseEntity baseEntity;

  const BookmarkRestaurantSuccess(this.baseEntity);
}
