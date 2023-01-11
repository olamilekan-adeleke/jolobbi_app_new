import 'package:flutter/material.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/navigator/navigator.dart';
import '../../../../../cores/utils/utils.dart';
import '../../pages/login_view.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

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
              onChanged: (_) {},
              validator: nameValidator,
              textInputType: TextInputType.text,
            ),
            verticalSpace(),
            TextFieldWidget(
              title: 'Email',
              hintText: 'test@user.com',
              onChanged: (_) {},
              validator: emailValidator,
              textInputType: TextInputType.emailAddress,
            ),
            verticalSpace(),
            TextFieldWidget(
              title: 'Mobile Number',
              hintText: '0801 234 5678',
              onChanged: (_) {},
              validator: mobileValidator,
              textInputType: TextInputType.number,
            ),
            verticalSpace(),
            TextFieldWidget(
              title: "Password",
              hintText: '********',
              isPassword: true,
              onChanged: (_) {},
              validator: passwordValidator,
              textInputType: TextInputType.visiblePassword,
            ),
            verticalSpace(50),
            Button(text: 'Create Account', onTap: () {}),
            verticalSpace(20),
            GestureDetector(
              onTap: () => AppRouter.instance.navigateTo(LoginView.route),
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
