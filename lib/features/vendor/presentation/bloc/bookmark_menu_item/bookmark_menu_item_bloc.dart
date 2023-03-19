import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/entity/base_entity.dart';
import '../../../domain/usecases/bookmark_menu_item_usecase.dart';

part 'bookmark_menu_item_event.dart';
part 'bookmark_menu_item_state.dart';

class BookmarkMenuItemBloc
    extends Bloc<BookmarkMenuItemEvent, BookmarkMenuItemState> {
  final BookmarkMenuItemUsecase bookmarkMenuItemUsecase;

  BookmarkMenuItemBloc({
    required this.bookmarkMenuItemUsecase,
  }) : super(BookmarkMenuItemInitial()) {
    on<BookmarkMenuItemEvent>((event, emit) async {
      emit(BookmarkMenuItemLoading());

      final result = await bookmarkMenuItemUsecase(event.id);

      result.fold(
        (failure) => emit(BookmarkMenuItemError(message: failure.message)),
        (baseEntity) => emit(BookmarkMenuItemSuccess(baseEntity: baseEntity)),
      );
    });
  }
}
