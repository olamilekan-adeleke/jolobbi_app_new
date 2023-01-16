import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/navigator/navigator.dart';
import '../../../../../cores/utils/utils.dart';
import '../../bloc/sign_up/sign_up_bloc.dart';
import '../../cubit/sign_up_form_state_cubit.dart';
import '../../pages/login_view.dart';
import '../../presentation.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

  static final SignUpFormCubit _signUpFormCubit =
      SetUpLocators.getIt<SignUpFormCubit>();
  static final SignUpBloc _signUpBloc = SetUpLocators.getIt<SignUpBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(20)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextWidget(
              'Create an account',
              fontWeight: FontWeight.w600,
              fontSize: sp(18),
            ),
            TextWidget(
              'Enter your details to create your account',
              fontWeight: FontWeight.w300,
              fontSize: sp(14),
            ),
            verticalSpace(20),
            TextFieldWidget(
              title: 'Name',
              hintText: 'Test User',
              onChanged: _signUpFormCubit.onFullNameChange,
              validator: nameValidator,
              textInputType: TextInputType.text,
            ),
            verticalSpace(),
            TextFieldWidget(
              title: 'Username',
              hintText: 'JohnDoe',
              onChanged: _signUpFormCubit.onUsernameChange,
              validator: usernameValidator,
              textInputType: TextInputType.text,
            ),
            verticalSpace(),
            TextFieldWidget(
              title: 'Email',
              hintText: 'test@user.com',
              onChanged: _signUpFormCubit.onEmailChange,
              validator: emailValidator,
              textInputType: TextInputType.emailAddress,
            ),
            verticalSpace(),
            TextFieldWidget(
              title: 'Mobile Number',
              hintText: '0801 234 5678',
              onChanged: _signUpFormCubit.onPhoneNumberChange,
              validator: mobileValidator,
              textInputType: TextInputType.number,
            ),
            verticalSpace(),
            TextFieldWidget(
              title: "Password",
              hintText: '********',
              isPassword: true,
              onChanged: _signUpFormCubit.onPasswordChange,
              validator: passwordValidator,
              textInputType: TextInputType.visiblePassword,
            ),
            verticalSpace(50),
            BlocBuilder<SignUpFormCubit, SignUpFormModel>(
              bloc: _signUpFormCubit,
              builder: (context, state) {
                final bool isFormValid = state.status == FormzStatus.valid;

                return BlocBuilder<SignUpBloc, SignUpState>(
                  bloc: _signUpBloc,
                  builder: (context, state) {
                    if (state is SignUpLoading) return const Button.loading();

                    return Button(
                      active: isFormValid,
                      text: 'Create Account',
                      onTap: () => _signUpBloc.add(
                        SignUpEvent(_signUpFormCubit.state),
                      ),
                    );
                  },
                );
              },
            ),
            verticalSpace(20),
            GestureDetector(
              onTap: () => AppRouter.instance.navigateToAndReplace(
                LoginView.route,
              ),
              child: Center(
                child: TwoSpanTextWidget(
                  'Have An Account? ',
                  'Click To Login',
                  fontSize: sp(11),
                  fontSize2: sp(11),
                  textColor2: kcPrimaryColor,
                  fontWeight2: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
