part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();  

  @override
  List<Object> get props => [];
}
class AuthenticatedState extends AuthenticationState {}

class UnAuthenticatedState extends AuthenticationState {}
