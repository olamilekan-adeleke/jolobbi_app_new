import 'package:flutter/material.dart';
import 'package:jolobbi_app_new/cores/navigator/navigator.dart';
import 'package:jolobbi_app_new/cores/utils/utils.dart';
import '../../../../cores/components/components.dart';
import '../widgets/cart_widget/food_cart_header_widget.dart';
import '../widgets/cart_widget/food_cart_list_widget.dart';
import 'confirm_food_order_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: [
          const FoodCartHeaderWidget(),
          verticalSpace(20),
          const FoodCartListWidget(),
          verticalSpace(40),
          Button(
            text: "Checkout",
            onTap: () => AppRouter.instance.navigateTo(
              ConfirmFoodOrderView.route,
            ),
          ),
          verticalSpace(20),
        ],
      ),
    );
  }
}
