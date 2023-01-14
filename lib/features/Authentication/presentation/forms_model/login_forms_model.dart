import 'package:equatable/equatable.dart';

import '../enum/auth_enum.dart';

class LoginFromzModel extends Equatable {
  const LoginFromzModel({
    this.email = '',
    this.password = '',
    this.loginStatus = LoginFormStatus.unknown,
  });

  final String email;
  final String password;
  final LoginFormStatus loginStatus;

  LoginFromzModel copyWith({
    String? email,
    String? password,
    LoginFormStatus? loginStatus,
  }) {
    email = email ?? this.email;
    password = password ?? this.password;
    loginStatus = validateModel(email, password);

    return LoginFromzModel(
      email: email,
      password: password,
      loginStatus: loginStatus,
    );
  }

  LoginFormStatus validateModel(
    String email,
    String password,
  ) {
    if (email.isEmpty || password.isEmpty) {
      return LoginFormStatus.error;
    }

    return LoginFormStatus.success;
  }

  @override
  List<Object?> get props => [email, password, loginStatus];
}
