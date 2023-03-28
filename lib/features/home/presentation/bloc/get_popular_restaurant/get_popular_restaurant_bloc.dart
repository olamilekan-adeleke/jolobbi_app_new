import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/shop_details_entity.dart';
import '../../../domain/usecases/get_popular_restaurant_usecase.dart';

part 'get_popular_restaurant_event.dart';
part 'get_popular_restaurant_state.dart';

class GetPopularRestaurantBloc
    extends Bloc<GetPopularRestaurantEvent, GetPopularRestaurantState> {
  final GetPopularRestaurantUsecase getPopularRestaurantUsecase;

  String? lastDocId;

  GetPopularRestaurantBloc({
    required this.getPopularRestaurantUsecase,
  }) : super(GetPopularRestaurantInitial()) {
    on<GetPopularRestaurantEvent>((event, emit) async {
      if (lastDocId == null) {
        emit(GetPopularRestaurantLoading());
      } else {
        emit(GetPopularRestaurantLoadingMore());
      }

      final result = await getPopularRestaurantUsecase(
        GetPopularRestaurantParams(lastDocId: lastDocId),
      );

      result.fold(
        (l) {
          if (lastDocId == null) {
            emit(GetPopularRestaurantError(l.message));
          } else {
            emit(GetPopularRestaurantMoreError(l.message));
          }
        },
        (r) {
          if (r.isNotEmpty) lastDocId = r.last.id;
          emit(GetPopularRestaurantSuccess(r));
        },
      );
    });
  }
}
