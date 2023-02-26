import 'package:flutter/material.dart';
import '../../../../../cores/constants/constants.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/utils/utils.dart';

class FoodCartHeaderWidget extends StatelessWidget {
  const FoodCartHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const AppBarWidget('Cart', showBackButton: false),
        TextWidget(
          "Item In Cart",
          fontSize: sp(18),
          fontWeight: FontWeight.w500,
          textColor: kcSoftTextColor.withOpacity(0.5),
        ),
      ],
    );
  }
}
