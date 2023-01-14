import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(UnAuthenticatedState()) {
    on<AuthenticationEvent>((event, emit) {});

    on<ChangeAuthStateEvent>((event, emit) {
      if (event.isAuthenticated) {
        emit(AuthenticatedState());
      } else {
        emit(UnAuthenticatedState());
      }
    });
  }
}
