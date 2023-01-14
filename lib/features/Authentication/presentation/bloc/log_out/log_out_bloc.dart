import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../cores/failures/base.dart';
import '../../../../../cores/usecase/params.dart';
import '../../../domain/usecases/logout_usecase.dart';

part 'log_out_event.dart';
part 'log_out_state.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> {
  final LogOutUsecase _logOutUsecase;

  LogOutBloc({required LogOutUsecase logOutUsecase})
      : _logOutUsecase = logOutUsecase,
        super(LogOutInitial()) {
    on<LogOutEvent>((event, emit) async {
      emit(LogOutLoading());

      final Either<Failures, void> result =
          await _logOutUsecase(const NoParams());

      result.fold(
        (failures) => emit(LogOutError(failures.message)),
        (_) => emit(LogOutSuccess()),
      );
    });
  }
}
