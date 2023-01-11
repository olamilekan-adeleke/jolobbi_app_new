import 'package:flutter/material.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/navigator/app_router.dart';
import '../../../../cores/utils/sizer_utils.dart';
import 'login_view.dart';
import 'sign_up_view.dart';

class IntroScreen extends StatelessWidget {
  static const route = "/";

  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      bg: Colors.orange.shade50,
      useSingleScroll: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          horizontalSpace(double.infinity),
          verticalSpace(30),
          const ImageWidget(
            imageTypes: ImageTypes.svg,
            imageUrl: "assets/svg/onboarding/intro.svg",
          ),
          verticalSpace(20),
          TextWidget(
            "Find a Restaurant",
            fontWeight: FontWeight.w700,
            fontSize: sp(20),
          ),
          verticalSpace(5),
          SizedBox(
            width: sw(60),
            child: TextWidget(
              "Fastest operation to provide food to your door step in little to no time",
              fontSize: sp(14),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Button(
                  text: "Login",
                  onTap: () => AppRouter.instance.navigateTo(LoginView.route),
                ),
              ),
              horizontalSpace(),
              Expanded(
                child: Button.withBorderLine(
                  text: "Create Account",
                  textColor: Colors.black,
                  onTap: () => AppRouter.instance.navigateTo(SignUpView.route),
                ),
              ),
            ],
          ),
          verticalSpace(20),
        ],
      ),
    );
  }
}
