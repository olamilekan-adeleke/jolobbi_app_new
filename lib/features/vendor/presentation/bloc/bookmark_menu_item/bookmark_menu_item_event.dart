part of 'bookmark_menu_item_bloc.dart';

class BookmarkMenuItemEvent extends Equatable {
  final String id;
  const BookmarkMenuItemEvent(this.id);

  @override
  List<Object> get props => [id];
}
