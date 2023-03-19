import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/shop_details_entity.dart';
import '../../../domain/usecases/search_restaurant_usecase.dart';

part 'search_restaurant_event.dart';
part 'search_restaurant_state.dart';

class SearchRestaurantBloc
    extends Bloc<SearchRestaurantEvent, SearchRestaurantState> {
  final SearchRestaurantUsecase searchRestaurantUsecase;

  String? lastDocId;

  SearchRestaurantBloc({
    required this.searchRestaurantUsecase,
  }) : super(SearchRestaurantInitial()) {
    on<SearchRestaurantEvent>((event, emit) async {
      emit(SearchRestaurantLoading());

      final result = await searchRestaurantUsecase(
        SearchRestaurantParams(query: event.query, lastDocId: lastDocId),
      );

      result.fold(
        (l) => emit(SearchRestaurantError(l.message)),
        (r) {
          if (r.isNotEmpty) lastDocId = r.last.name;

          emit(SearchRestaurantSuccess(r));
        },
      );
    });
  }
}
