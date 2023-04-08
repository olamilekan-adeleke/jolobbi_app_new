import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecases/get_order_by_id_usecase.dart';

part 'get_order_by_id_event.dart';
part 'get_order_by_id_state.dart';

class GetOrderByIdBloc extends Bloc<GetOrderByIdEvent, GetOrderByIdState> {
  final GetOrderByIdUsecase getOrderByIdUsecase;

  GetOrderByIdBloc({
    required this.getOrderByIdUsecase,
  }) : super(GetOrderByIdInitial()) {
    on<GetOrderByIdEvent>((event, emit) async {
      emit(GetOrderByIdLoading());

      final result = await getOrderByIdUsecase(event.id);

      result.fold(
        (l) => emit(GetOrderByIdError(l.message)),
        (r) => emit(GetOrderByIdSuccess(r)),
      );
    });
  }
}
