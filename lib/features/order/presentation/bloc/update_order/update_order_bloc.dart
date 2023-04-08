import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/entity/base_entity.dart';
import '../../../domain/usecases/update_order_usecase.dart';

part 'update_order_event.dart';
part 'update_order_state.dart';

class UpdateOrderBloc extends Bloc<UpdateOrderEvent, UpdateOrderState> {
  final UpdateOrderUsecase updateOrderUsecase;

  UpdateOrderBloc({
    required this.updateOrderUsecase,
  }) : super(UpdateOrderInitial()) {
    on<UpdateOrderEvent>((event, emit) async {
      emit(UpdateOrderLoading());

      final result = await updateOrderUsecase(event.params);

      result.fold(
        (l) => emit(UpdateOrderError(l.message)),
        (r) => emit(UpdateOrderSuccess(r)),
      );
    });
  }
}
