part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class ChangeAuthStateEvent extends AuthenticationEvent {
  final bool isAuthenticated;

  const ChangeAuthStateEvent(this.isAuthenticated);
}
