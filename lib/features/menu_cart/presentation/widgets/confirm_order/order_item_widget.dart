import 'package:flutter/material.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/utils/utils.dart';
import '../cart_widget/food_cart_list_widget.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(
          "Order Items",
          fontWeight: FontWeight.w500,
          fontSize: sp(18),
        ),
        verticalSpace(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return const FoodCartItemWidget();
          },
        ),
      ],
    );
  }
}
