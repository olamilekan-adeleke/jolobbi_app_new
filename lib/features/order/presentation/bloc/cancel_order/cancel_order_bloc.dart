import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/entity/base_entity.dart';
import '../../../domain/usecases/cancel_order_usecase.dart';

part 'cancel_order_event.dart';
part 'cancel_order_state.dart';

class CancelOrderBloc extends Bloc<CancelOrderEvent, CancelOrderState> {
  final CancelOrderUsecase cancelOrderUsecase;

  CancelOrderBloc({
    required this.cancelOrderUsecase,
  }) : super(CancelOrderInitial()) {
    on<CancelOrderEvent>((event, emit) async {
      emit(CancelOrderLoading());

      final result = await cancelOrderUsecase(event.params);

      result.fold(
        (failure) => emit(CancelOrderError(failure.message)),
        (entity) => emit(CancelOrderSuccess(entity)),
      );
    });
  }
}
