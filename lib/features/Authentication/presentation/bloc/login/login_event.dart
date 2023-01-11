part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  final LoginDataParams loginDataParams;

  const LoginEvent(this.loginDataParams);

  @override
  List<Object> get props => [];
}
