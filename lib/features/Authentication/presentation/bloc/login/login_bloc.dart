import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../cores/failures/base.dart';
import '../../../domain/entities/auth_result_entity.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;

  LoginBloc({required this.loginUsecase}) : super(LoginInitial()) {
    on<LoginEvent>(
      (event, emit) async {
        emit(LoginLoading());

        final Either<Failures, AuthResultEntity> result =
            await loginUsecase(event.loginDataParams);

        result.fold((failure) {
          emit(LoginError(failure.message));
        }, (success) {
          emit(LoginSuccess());
        });
      },
    );
  }
}
