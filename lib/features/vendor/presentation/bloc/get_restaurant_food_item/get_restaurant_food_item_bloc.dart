import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/domain/entities/menu_item_entity.dart';
import '../../../domain/usecases/get_restaurant_food_item_usecase.dart';

part 'get_restaurant_food_item_event.dart';
part 'get_restaurant_food_item_state.dart';

class GetRestaurantFoodItemBloc
    extends Bloc<GetRestaurantFoodItemEvent, GetRestaurantFoodItemState> {
  final GetRestaurantFoodItemUsecase getRestaurantFoodItemUsecase;

  String? lastDocId;
  List<MenuItemEntity> menuItemEntities = [];

  bool isBusy = false;

  GetRestaurantFoodItemBloc({
    required this.getRestaurantFoodItemUsecase,
  }) : super(GetRestaurantFoodItemInitial()) {
    on<GetRestaurantFoodItemEvent>((event, emit) async {
      if (isBusy) return;

      isBusy = true;
      if (event.shouldGetFreshData) {
        lastDocId = null;
        menuItemEntities = [];
      }

      if (lastDocId == null) {
        emit(GetRestaurantFoodItemLoading());
      } else {
        emit(GetRestaurantFoodItemLoadingMore());
      }

      final result = await getRestaurantFoodItemUsecase(
        GetRestaurantFoodItemParams(id: event.id, lastDocId: lastDocId),
      );

      result.fold(
        (failure) {
          if (lastDocId == null) {
            emit(GetRestaurantFoodItemError(message: failure.message));
          } else {
            emit(GetRestaurantFoodItemErrorMore(message: failure.message));
          }
          isBusy = false;
        },
        (menuItemEntities) {
          this.menuItemEntities.addAll(menuItemEntities);
          if (menuItemEntities.isNotEmpty) {
            lastDocId = menuItemEntities.last.name;
          }

          emit(GetRestaurantFoodItemSuccess(menuItemEntities));
          isBusy = false;
        },
      );
    });
  }
}
