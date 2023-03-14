import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/entity/base_entity.dart';
import '../../../domain/usecases/bookmark_restaurant_usecae.dart';

part 'bookmark_restaurant_event.dart';
part 'bookmark_restaurant_state.dart';

class BookmarkRestaurantBloc
    extends Bloc<BookmarkRestaurantEvent, BookmarkRestaurantState> {
  final BookmarkRestaurantUsecase bookmarkRestaurantUsecase;

  BookmarkRestaurantBloc({
    required this.bookmarkRestaurantUsecase,
  }) : super(BookmarkRestaurantInitial()) {
    on<BookmarkRestaurantEvent>((event, emit) async {
      emit(BookmarkRestaurantLoading());

      final result = await bookmarkRestaurantUsecase(
        BookmarkRestaurantParams(id: event.id),
      );

      result.fold(
        (l) => emit(BookmarkRestaurantError(l.message)),
        (r) => emit(BookmarkRestaurantSuccess(r)),
      );
    });
  }
}
