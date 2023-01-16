import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/utils/formz_validator/email_formz_validator.dart';
import '../../../../cores/utils/formz_validator/password_formz_validator.dart';
import '../../../../cores/utils/formz_validator/required_formz_validator.dart';
import '../../../../cores/utils/formz_validator/username_formz_validator.dart';
import '../presentation.dart';

class SignUpFormCubit extends Cubit<SignUpFormModel> {
  SignUpFormCubit() : super(SignUpFormModel());

  void onEmailChange(String email) {
    emit(state.copyWith(email: Email.dirty(email)));
  }

  void onPasswordChange(String password) {
    emit(state.copyWith(password: Password.dirty(password)));
  }

  void onFullNameChange(String fullName) {
    emit(state.copyWith(fullName: Required.dirty(fullName)));
  }

  void onPhoneNumberChange(String phoneNumber) {
    emit(state.copyWith(phoneNumber: Required.dirty(phoneNumber)));
  }

  void onUsernameChange(String username) {
    emit(state.copyWith(username: Username.dirty(username)));
  }
}
