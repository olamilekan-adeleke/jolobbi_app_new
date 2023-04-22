import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/entity/base_entity.dart';
import '../../../domain/usecases/confirm_make_payment_usecase.dart';

part 'confirm_make_payment_event.dart';
part 'confirm_make_payment_state.dart';

class ConfirmMakePaymentBloc
    extends Bloc<ConfirmMakePaymentEvent, ConfirmMakePaymentState> {
  final ConfirmMakePaymentUsecase confirmMakePaymentUsecase;

  ConfirmMakePaymentBloc({
    required this.confirmMakePaymentUsecase,
  }) : super(ConfirmMakePaymentInitial()) {
    on<ConfirmMakePaymentEvent>((event, emit) async {
      emit(ConfirmMakePaymentLoading());

      final result = await confirmMakePaymentUsecase(event.orderId);

      result.fold(
        (failure) => emit(ConfirmMakePaymentError(failure.message)),
        (entity) => emit(ConfirmMakePaymentSuccess(entity)),
      );
    });
  }
}
