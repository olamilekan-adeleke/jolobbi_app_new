import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/shop_details_entity.dart';
import '../../../domain/usecases/get_all_resturant_usecase.dart';

part 'get_all_restaurant_event.dart';
part 'get_all_restaurant_state.dart';

class GetAllRestaurantBloc
    extends Bloc<GetAllRestaurantEvent, GetAllRestaurantState> {
  final GetAllRestaurantsUsecase getAllRestaurantsUsecase;

  String? lastDocId;
  List<ShopDetailsEntity> shops = [];

  bool isBusy = false;

  GetAllRestaurantBloc({
    required this.getAllRestaurantsUsecase,
  }) : super(GetAllRestaurantInitial()) {
    on<GetAllRestaurantEvent>((event, emit) async {
      if (event.getFreshData == true) {
        lastDocId = null;
        shops = [];
      }

      if (lastDocId == null) {
        emit(GetAllRestaurantLoading());
      } else {
        emit(GetAllRestaurantLoadingMore());
      }

      isBusy = true;

      final result = await getAllRestaurantsUsecase(
        GetRestaurantParams(lastDocId),
      );

      result.fold(
        (l) {
          if (lastDocId == null) {
            emit(GetAllRestaurantError(l.message));
          } else {
            emit(GetAllRestaurantErrorMore(l.message));
          }

          isBusy = false;
        },
        (r) {
          shops.addAll(r);
          if (r.isNotEmpty) lastDocId = r.last.name;

          emit(GetAllRestaurantSuccess(r));
          isBusy = false;
        },
      );
    });
  }
}
