import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/navigator/navigator.dart';
import '../../../../cores/utils/utils.dart';
import '../cubit/cart_items_cubit.dart';
import '../pages/cart_view.dart';

class CartIconWidget extends StatelessWidget {
  final Color? color;
  final double? size;
  const CartIconWidget({super.key, this.color, this.size});

  static final CartItemCubit _cartItemCubit =
      SetUpLocators.getIt<CartItemCubit>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouter.instance.navigateTo(MenuCartView.route),
      child: SizedBox(
        height: h(30),
        width: w(30),
        child: Stack(
          children: [
            Align(
              child: Icon(
                CupertinoIcons.shopping_cart,
                size: sp(size ?? 23),
                color: color,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: h(16),
                width: w(16),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: BlocBuilder<CartItemCubit, CartItemsList>(
                    bloc: _cartItemCubit,
                    builder: (context, state) {
                      return TextWidget(
                        state.cartItems.length.toString(),
                        fontSize: sp(14),
                        fontWeight: FontWeight.w500,
                        textColor: Colors.white,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
