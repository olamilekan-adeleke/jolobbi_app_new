import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecases/get_all_orders_usecase.dart';

part 'get_all_orders_event.dart';
part 'get_all_orders_state.dart';

class GetAllOrdersBloc extends Bloc<GetAllOrdersEvent, GetAllOrdersState> {
  final GetAllOrderUsecase getAllOrderUsecase;

  String? lastDocTime;
  bool isBusy = false;
  List<OrderEntity> orders = [];

  GetAllOrdersBloc({
    required this.getAllOrderUsecase,
  }) : super(GetAllOrdersInitial()) {
    on<GetAllOrdersEvent>((event, emit) async {
      if (isBusy) return;
      isBusy = true;

      if (event.getFreshData) {
        lastDocTime = null;
        orders = [];
      }

      if (orders.isEmpty) {
        emit(GetAllOrdersLoading());
      } else {
        emit(GetAllOrdersLoadingMore());
      }

      final result = await getAllOrderUsecase(lastDocTime);

      result.fold(
        (l) {
          isBusy = false;
          if (orders.isEmpty) {
            emit(GetAllOrdersError(l.message));
          } else {
            emit(GetAllOrdersErrorMore(l.message));
          }
        },
        (r) {
          isBusy = false;
          orders = r;
          if (r.isNotEmpty) lastDocTime = orders.last.timestamp.toString();
          emit(GetAllOrdersSuccess(orders));
        },
      );
    });
  }
}
