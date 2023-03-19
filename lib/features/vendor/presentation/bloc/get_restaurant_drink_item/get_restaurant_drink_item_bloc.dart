import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/domain/entities/menu_item_entity.dart';
import '../../../domain/usecases/get_restaurant_drink_item_usecae.dart';

part 'get_restaurant_drink_item_event.dart';
part 'get_restaurant_drink_item_state.dart';

class GetRestaurantDrinkItemBloc
    extends Bloc<GetRestaurantDrinkItemEvent, GetRestaurantDrinkItemState> {
  final GetRestaurantDrinkItemUsecase getRestaurantDrinkItemUsecase;

  String? lastDocId;
  List<MenuItemEntity> menuItemEntities = [];

  bool isBusy = false;

  GetRestaurantDrinkItemBloc({
    required this.getRestaurantDrinkItemUsecase,
  }) : super(GetRestaurantDrinkItemInitial()) {
    on<GetRestaurantDrinkItemEvent>((event, emit) async {
      if (isBusy) return;

      if (event.shouldGetFreshData) {
        lastDocId = null;
        menuItemEntities = [];
      }

      isBusy = true;
      if (lastDocId == null) {
        emit(GetRestaurantDrinkItemLoading());
      } else {
        emit(GetRestaurantDrinkItemLoadingMore());
      }

      final result = await getRestaurantDrinkItemUsecase(
        GetRestaurantDrinkItemParams(id: event.id, lastDocId: lastDocId),
      );

      result.fold(
        (failure) {
          if (lastDocId == null) {
            emit(GetRestaurantDrinkItemError(message: failure.message));
          } else {
            emit(GetRestaurantDrinkItemErrorMore(message: failure.message));
          }
          isBusy = false;
        },
        (menuItemEntities) {
          this.menuItemEntities.addAll(menuItemEntities);
          if (menuItemEntities.isNotEmpty) {
            lastDocId = menuItemEntities.last.name;
          }

          emit(GetRestaurantDrinkItemSuccess(menuItemEntities));
          isBusy = false;
        },
      );
    });
  }
}
