part of 'bookmark_menu_item_bloc.dart';

abstract class BookmarkMenuItemState extends Equatable {
  const BookmarkMenuItemState();

  @override
  List<Object> get props => [];
}

class BookmarkMenuItemInitial extends BookmarkMenuItemState {}

class BookmarkMenuItemLoading extends BookmarkMenuItemState {}

class BookmarkMenuItemError extends BookmarkMenuItemState {
  final String message;

  const BookmarkMenuItemError({required this.message});

  @override
  List<Object> get props => [message];
}

class BookmarkMenuItemSuccess extends BookmarkMenuItemState {
  final BaseEntity baseEntity;

  const BookmarkMenuItemSuccess({required this.baseEntity});

  @override
  List<Object> get props => [baseEntity];
}
