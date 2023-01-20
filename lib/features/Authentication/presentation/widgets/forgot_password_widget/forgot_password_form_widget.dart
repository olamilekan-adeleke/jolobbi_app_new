import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/utils/utils.dart';
import '../../bloc/forgot_password/forgot_password_bloc.dart';

class ForgotFormWidget extends StatelessWidget {
  const ForgotFormWidget({Key? key}) : super(key: key);

  static final TextEditingController emailTextEditingController =
      TextEditingController();
  static final ForgotPasswordBloc _bloc =
      SetUpLocators.getIt<ForgotPasswordBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextWidget(
            'Forgot Password',
            fontWeight: FontWeight.w600,
            fontSize: sp(18),
          ),
          SizedBox(
            width: sw(85),
            child: TextWidget(
              'Enter your email address and a confirmation link will be sent to the email address if an account for it was found ',
              fontWeight: FontWeight.w300,
              fontSize: sp(14),
              textAlign: TextAlign.left,
            ),
          ),
          verticalSpace(20),
          TextFieldWidget(
            title: "Email",
            hintText: 'test@user.con',
            onChanged: (_) {},
            textEditingController: emailTextEditingController,
            validator: emailValidator,
          ),
          verticalSpace(60),
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is ForgotPasswordLoading) {
                return const Button.loading();
              }

              return Button(
                text: 'Get Reset Link',
                onTap: () => _bloc.add(
                  ForgotPasswordEvent(emailTextEditingController.text),
                ),
              );
            },
          ),
          verticalSpace(20),
        ],
      ),
    );
  }
}
