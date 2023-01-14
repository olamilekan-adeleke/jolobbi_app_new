import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../cores/failures/base.dart';
import '../../../domain/usecases/forgot_password_usecase.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUsecase _forgotPasswordUsecase;

  ForgotPasswordBloc({required ForgotPasswordUsecase forgotPasswordUsecase})
      : _forgotPasswordUsecase = forgotPasswordUsecase,
        super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) async {
      emit(ForgotPasswordLoading());

      final Either<Failures, void> result =
          await _forgotPasswordUsecase(event.email);

      result.fold(
        (failures) => emit(ForgotPasswordError(failures.message)),
        (_) => emit(ForgotPasswordSuccess()),
      );
    });
  }
}
