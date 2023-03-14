import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/menu_item_entity.dart';
import '../../../domain/usecases/search_menu_usecase.dart';

part 'search_menu_item_event.dart';
part 'search_menu_item_state.dart';

class SearchMenuItemBloc
    extends Bloc<SearchMenuItemEvent, SearchMenuItemState> {
  final SearchMenuItemUsecase searchMenuItemUsecase;

  String? lastDocId;

  SearchMenuItemBloc({
    required this.searchMenuItemUsecase,
  }) : super(SearchMenuItemInitial()) {
    on<SearchMenuItemEvent>((event, emit) async {
      if (lastDocId == null) {
        emit(SearchMenuItemLoading());
      } else {
        emit(SearchMenuItemLoadingMore());
      }

      final result = await searchMenuItemUsecase(
        SearchMenuItemParams(query: event.query, lastDocId: lastDocId),
      );

      result.fold(
        (l) {
          if (lastDocId == null) {
            emit(SearchMenuItemError(l.message));
          } else {
            emit(SearchMenuItemErrorMore(l.message));
          }
        },
        (r) {
          lastDocId = r.last.id;
          emit(SearchMenuItemSuccess(r));
        },
      );
    });
  }
}
