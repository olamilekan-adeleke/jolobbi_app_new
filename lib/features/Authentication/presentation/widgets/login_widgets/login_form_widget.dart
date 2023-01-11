import 'package:flutter/material.dart';
import 'package:jolobbi_app_new/cores/components/custom_button.dart';
import 'package:jolobbi_app_new/cores/components/custom_textfiled.dart';
import 'package:jolobbi_app_new/cores/constants/color.dart';
import 'package:jolobbi_app_new/cores/navigator/app_router.dart';

import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../../../cores/utils/validator.dart';
import '../../pages/forgot_password_view.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

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
            onChanged: (_) {},
            validator: emailValidator,
            textInputType: TextInputType.emailAddress,
          ),
          verticalSpace(),
          TextFieldWidget(
            title: 'Password',
            hintText: '********',
            isPassword: true,
            onChanged: (_) {},
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
          Button(text: "Log In", onTap: () {}),
        ],
      ),
    );
  }
}
