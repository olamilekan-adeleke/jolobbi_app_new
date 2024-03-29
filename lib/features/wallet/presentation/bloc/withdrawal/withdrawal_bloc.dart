import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/entity/base_entity.dart';
import '../../../domain/usecases/withdrawal_usecase.dart';

part 'withdrawal_event.dart';
part 'withdrawal_state.dart';

class WithdrawalBloc extends Bloc<WithdrawalEvent, WithdrawalState> {
  final WithdrawalUsecase withdrawalUsecase;

  WithdrawalBloc({
    required this.withdrawalUsecase,
  }) : super(WithdrawalInitial()) {
    on<WithdrawalEvent>((event, emit) async {
      emit(WithdrawalLoading());

      final result = await withdrawalUsecase(WithdrawalParam(event.data));

      result.fold(
        (failure) => emit(WithdrawalError(failure.message)),
        (entity) => emit(WithdrawalSuccess(entity)),
      );
    });
  }
}
