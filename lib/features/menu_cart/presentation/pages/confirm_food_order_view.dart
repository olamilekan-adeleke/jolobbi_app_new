import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../widgets/confirm_order/order_deliver_widget.dart';
import '../widgets/confirm_order/order_fee_break_down_widget.dart';
import '../widgets/confirm_order/order_item_widget.dart';
import '../widgets/confirm_order/order_payment_type_widget.dart';

class ConfirmFoodOrderView extends StatelessWidget {
  static const String route = '/confirmFoodOrderView';

  const ConfirmFoodOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const AppBarWidget("Order Confirmation", useSpacer: true),
          const OrderItemWidget(),
          verticalSpace(20),
          const OrderDeliverWidget(),
          verticalSpace(20),
          const OrderBreakDownWidget(),
          verticalSpace(20),
          const OrderPaymentTypeWidget(),
          verticalSpace(40),
          Button(text: "Place Order", onTap: () {}),
          verticalSpace(20),
        ],
      ),
    );
  }
}
