import 'package:flutter/material.dart';
import 'package:jolobbi_app_new/cores/constants/constants.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/utils/utils.dart';

class OrderDeliverWidget extends StatelessWidget {
  const OrderDeliverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              "Delivery Address",
              fontSize: sp(18),
              fontWeight: FontWeight.w500,
            ),
            TextWidget(
              "Change",
              fontSize: sp(14),
              textColor: kcSoftTextColor.withOpacity(0.5),
              decoration: TextDecoration.underline,
            ),
          ],
        ),
        verticalSpace(5),
        GestureDetector(
          onTap: () {},
          child: AbsorbPointer(
            absorbing: true,
            child: TextFieldWidget(
              hintText: "Enter your delivery address",
              maxLine: null,
              textEditingController: TextEditingController(
                text: "Km 3, No way home, Brooklyn, NY",
              ),
              suffix: Icons.arrow_forward_ios_outlined,
            ),
          ),
        ),
      ],
    );
  }
}
