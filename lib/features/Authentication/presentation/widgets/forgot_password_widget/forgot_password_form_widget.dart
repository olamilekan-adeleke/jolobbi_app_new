import 'package:flutter/material.dart';

import '../../../../../cores/components/custom_button.dart';
import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/custom_textfiled.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../../../cores/utils/validator.dart';

class ForgotFormWidget extends StatelessWidget {
  const ForgotFormWidget({Key? key}) : super(key: key);

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
            validator: emailValidator,
          ),
          verticalSpace(60),
          // BlocBuilder<ForgotPasswordCubit, ForgotPasswordModel>(
          //   builder: (context, state) {
          //     if (state.forgotPasswordStatus == ForgotPasswordStatus.busy) {
          //       return const CustomButton.loading();
          //     }

          //     return CustomButton(
          //       text: 'Submit',
          //       onTap: context.read<ForgotPasswordCubit>().onSubmitFom,
          //     );
          //   },
          // ),
          Button(text: 'Get Reset Link', onTap: () {}),
          verticalSpace(20),
        ],
      ),
    );
  }
}
