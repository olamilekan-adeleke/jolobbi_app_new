import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/entity/base_entity.dart';
import '../../../domain/usecases/log_flutter_wave_trans_usecase.dart';
import '../../../domain/usecases/log_paystack_trans_usecase.dart';

part 'log_trans_event.dart';
part 'log_trans_state.dart';

class LogTransBloc extends Bloc<LogTransEvent, LogTransState> {
  final LogFlutterWaveTransUsecase logFlutterWaveTransUsecase;
  final LogPaystackTransUsecase logPaystackTransUsecase;

  LogTransBloc({
    required this.logFlutterWaveTransUsecase,
    required this.logPaystackTransUsecase,
  }) : super(LogTransInitial()) {
    on<LogFlutterWaveTransEvent>((event, emit) async {
      emit(LogTransLoading());

      final result = await logFlutterWaveTransUsecase(event.data);

      result.fold(
        (failure) => emit(LogTransError(failure.message)),
        (entity) => emit(LogTransSuccess(entity)),
      );
    });

    on<LogPaystackTransEvent>((event, emit) async {
      emit(LogTransLoading());

      final result = await logPaystackTransUsecase(event.data);

      result.fold(
        (failure) => emit(LogTransError(failure.message)),
        (entity) => emit(LogTransSuccess(entity)),
      );
    });
  }
}
