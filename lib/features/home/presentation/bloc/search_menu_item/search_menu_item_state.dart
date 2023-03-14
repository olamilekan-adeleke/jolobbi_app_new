part of 'search_menu_item_bloc.dart';

abstract class SearchMenuItemState extends Equatable {
  const SearchMenuItemState();

  @override
  List<Object> get props => [];
}

class SearchMenuItemInitial extends SearchMenuItemState {}

class SearchMenuItemLoading extends SearchMenuItemState {}

class SearchMenuItemLoadingMore extends SearchMenuItemState {}

class SearchMenuItemError extends SearchMenuItemState {
  final String message;

  const SearchMenuItemError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMenuItemErrorMore extends SearchMenuItemState {
  final String message;

  const SearchMenuItemErrorMore(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMenuItemSuccess extends SearchMenuItemState {
  final List<MenuItemEntity> menuItems;

  const SearchMenuItemSuccess(this.menuItems);
}
