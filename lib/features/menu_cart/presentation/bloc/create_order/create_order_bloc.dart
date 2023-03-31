import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/entity/base_entity.dart';
import '../../../domain/usecases/create_order_usecase.dart';
import '../../formz/order_formz.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  final CreateOrderUsecase createOrderUsecase;

  CreateOrderBloc({
    required this.createOrderUsecase,
  }) : super(CreateOrderInitial()) {
    on<CreateOrderEvent>((event, emit) async {
      emit(CreateOrderLoading());

      final result = await createOrderUsecase(event.order);

      result.fold(
        (l) => emit(CreateOrderError(l.message)),
        (r) => emit(CreateOrderSuccess(r)),
      );
    });
  }
}
