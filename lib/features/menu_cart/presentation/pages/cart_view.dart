import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/navigator/navigator.dart';
import '../../../../cores/utils/utils.dart';
import '../cubit/cart_items_cubit.dart';
import '../widgets/cart_widget/food_cart_header_widget.dart';
import '../widgets/cart_widget/food_cart_list_widget.dart';
import 'order/confirm_food_order_view.dart';

class MenuCartView extends StatelessWidget {
  static const String route = "/menu_cart";

  const MenuCartView({super.key});

  static final CartItemCubit _cartItemCubit =
      SetUpLocators.getIt<CartItemCubit>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: [
          const FoodCartHeaderWidget(),
          verticalSpace(20),
          BlocBuilder<CartItemCubit, CartItemsList>(
            bloc: _cartItemCubit,
            builder: (context, state) {
              if (state.cartItems.isEmpty) return _buildEmptyCart();

              return const FoodCartListWidget();
            },
          ),
          verticalSpace(40),
          BlocBuilder<CartItemCubit, CartItemsList>(
            bloc: _cartItemCubit,
            builder: (context, state) {
              return Visibility(
                visible: state.cartItems.isNotEmpty,
                child: Button(
                  text: "Checkout",
                  onTap: () => AppRouter.instance.navigateTo(
                    ConfirmFoodOrderView.route,
                  ),
                ),
              );
            },
          ),
          verticalSpace(20),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        verticalSpace(20),
        ImageWidget(
          imageTypes: ImageTypes.asset,
          imageUrl: "assets/icons/cart/empty_box.png",
          color: kcSoftTextColor.withOpacity(0.5),
          height: h(200),
          width: w(200),
        ),
        verticalSpace(),
        TextWidget(
          "Your cart is empty, add some items to it",
          fontSize: sp(18),
          fontWeight: FontWeight.w300,
          textAlign: TextAlign.center,
          textColor: kcSoftTextColor.withOpacity(0.7),
        ),
      ],
    );
  }
}
