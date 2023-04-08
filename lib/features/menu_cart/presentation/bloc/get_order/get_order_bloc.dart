import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../order/domain/entities/order_entity.dart';
import '../../../domain/usecases/get_order_usecase.dart';

part 'get_order_event.dart';
part 'get_order_state.dart';

class GetOrderBloc extends Bloc<GetOrderEvent, GetOrderState> {
  final GetOrderUsecase getOrderUsecase;

  String? lastDoc;
  List<OrderEntity> orders = [];
  bool isBusy = false;

  GetOrderBloc({required this.getOrderUsecase}) : super(GetOrderInitial()) {
    on<GetOrderEvent>((event, emit) async {
      if (isBusy) return;

      isBusy = true;
      if (lastDoc == null) {
        emit(GetOrderLoading());
      } else {
        emit(GetOrderLoadingMore());
      }

      final result = await getOrderUsecase(lastDoc);

      result.fold(
        (l) {
          isBusy = false;
          if (lastDoc == null) {
            emit(GetOrderError(l.message));
          } else {
            emit(GetOrderErrorMore(l.message));
          }
        },
        (r) {
          isBusy = false;
          orders.addAll(r);
          if (r.isEmpty) lastDoc = r.last.orderId;
          emit(GetOrderSuccess(r));
        },
      );
    });
  }
}
