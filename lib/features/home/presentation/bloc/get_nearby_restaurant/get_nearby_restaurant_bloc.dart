import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/usecase/params.dart';
import '../../../domain/entities/shop_details_entity.dart';
import '../../../domain/usecases/get_nearby_restaurants_usecae.dart';

part 'get_nearby_restaurant_event.dart';
part 'get_nearby_restaurant_state.dart';

class GetNearbyRestaurantBloc
    extends Bloc<GetNearbyRestaurantEvent, GetNearbyRestaurantState> {
  final GetNearbyRestaurantUsecase getNearbyRestaurantUsecase;

  GetNearbyRestaurantBloc({
    required this.getNearbyRestaurantUsecase,
  }) : super(GetNearbyRestaurantInitial()) {
    on<GetNearbyRestaurantEvent>((event, emit) async {
      emit(GetNearbyRestaurantLoading());

      final result = await getNearbyRestaurantUsecase(const NoParams());

      result.fold(
        (l) => emit(GetNearbyRestaurantError(l.message)),
        (r) => emit(GetNearbyRestaurantSuccess(r)),
      );
    });
  }
}
