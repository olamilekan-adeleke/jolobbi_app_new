import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/utils/utils.dart';
import '../../cubit/cart_items_cubit.dart';
import '../../formz/cart_item_formz.dart';
import '../cart_widget/food_cart_list_widget.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({super.key});

  static final CartItemCubit _cartItemCubit =
      SetUpLocators.getIt<CartItemCubit>();

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
        BlocBuilder<CartItemCubit, CartItemsList>(
          bloc: _cartItemCubit,
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
                final CartItemFormz cartItem = state.cartItems[index];
                return FoodCartItemWidget(cartItem);
              },
            );
          },
        ),
      ],
    );
  }
}
