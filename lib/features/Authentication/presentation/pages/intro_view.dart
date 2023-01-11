import 'package:flutter/material.dart';
import 'package:jolobbi_app_new/cores/components/custom_scaffold_widget.dart';
import 'package:jolobbi_app_new/cores/components/custom_text_widget.dart';
import 'package:jolobbi_app_new/cores/components/image_widget.dart';
import 'package:jolobbi_app_new/cores/utils/sizer_utils.dart';

class IntroScreen extends StatelessWidget {
  static const route = "/";

  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          horizontalSpace(double.infinity),
          verticalSpace(30),
          SizedBox(
            width: w(300),
            height: h(200),
            child: const ImageWidget(
              imageTypes: ImageTypes.svg,
              imageUrl: "assets/svg/onboarding/intro.svg",
            ),
          ),
          verticalSpace(40),
          TextWidget(
            "Find a Restaurant",
            fontWeight: FontWeight.w700,
            fontSize: sp(20),
          ),
          verticalSpace(5),
          SizedBox(
            width: sw(30),
            child: TextWidget(
              "Fastest operation to provide food to your door step in little to no time",
              fontWeight: FontWeight.w700,
              fontSize: sp(14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
