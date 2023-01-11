import 'package:flutter_bloc/flutter_bloc.dart';

import '../forms_model/login_forms_model.dart';

class LoginCubit extends Cubit<LoginFromzModel> {
  LoginCubit() : super(const LoginFromzModel());

  void onEmailChange(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChange(String password) {
    emit(state.copyWith(password: password));
  }
}
