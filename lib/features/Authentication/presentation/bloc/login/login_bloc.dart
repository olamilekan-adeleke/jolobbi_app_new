import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;

  LoginBloc({required this.loginUsecase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      emit(LoginLoading());

      loginUsecase(event.loginDataParams).then((either) {
        either.fold(
          (failure) => emit(LoginError(failure.message)),
          (success) => emit(LoginSuccess()),
        );
      });
    });
  }
}
