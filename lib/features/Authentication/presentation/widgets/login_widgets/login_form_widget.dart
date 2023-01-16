import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/navigator/navigator.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../bloc/login/login_bloc.dart';
import '../../cubit/login_form_state_cubit.dart';
import '../../enum/auth_enum.dart';
import '../../forms_model/login_forms_model.dart';
import '../../pages/pages.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  static final LoginCubit _loginCubit = SetUpLocators.getIt();
  static final LoginBloc _bloc = SetUpLocators.getIt();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextWidget(
            'Login to your account',
            fontWeight: FontWeight.w600,
            fontSize: sp(18),
          ),
          TextWidget(
            'Enter your email and password to access your account',
            fontWeight: FontWeight.w300,
            fontSize: sp(14),
          ),
          verticalSpace(20),
          TextFieldWidget(
            title: "Email",
            hintText: 'user@test.com',
            onChanged: _loginCubit.onEmailChange,
            validator: emailValidator,
            textInputType: TextInputType.emailAddress,
          ),
          verticalSpace(),
          TextFieldWidget(
            title: 'Password',
            hintText: '********',
            isPassword: true,
            onChanged: _loginCubit.onPasswordChange,
            validator: passwordValidator,
            textInputType: TextInputType.visiblePassword,
          ),
          verticalSpace(5),
          GestureDetector(
            onTap: () => AppRouter.instance.navigateTo(
              ForgotPasswordView.route,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextWidget(
                'Forgot Password?',
                fontWeight: FontWeight.w500,
                fontSize: sp(11),
                textColor: kcPrimaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          verticalSpace(60),
          BlocBuilder<LoginCubit, LoginFromzModel>(
            bloc: _loginCubit,
            builder: (context, cubitState) {
              final bool active =
                  cubitState.loginStatus == LoginFormStatus.success;

              return BlocBuilder<LoginBloc, LoginState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is LoginLoading) return const Button.loading();

                  return Button(
                    active: active,
                    text: "Log In",
                    onTap: () {
                      final LoginDataParams login = LoginDataParams(
                        email: cubitState.email,
                        password: cubitState.password,
                      );

                      _bloc.add(LoginEvent(login));
                    },
                  );
                },
              );
            },
          ),
          verticalSpace(),
          GestureDetector(
            onTap: () {
              AppRouter.instance.navigateToAndReplace(SignUpView.route);
            },
            child: Center(
              child: TwoSpanTextWidget(
                'New here? ',
                'Create an account',
                fontSize: sp(11),
                fontSize2: sp(11),
                textColor2: kcPrimaryColor,
                fontWeight2: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
