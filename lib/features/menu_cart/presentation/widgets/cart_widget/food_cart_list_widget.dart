import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../../home/domain/entities/menu_item_entity.dart';
import '../../cubit/cart_items_cubit.dart';
import '../../formz/cart_item_formz.dart';
import '../others/cart_item_counter_widget.dart';

class FoodCartListWidget extends StatelessWidget {
  const FoodCartListWidget({super.key});

  static final CartItemCubit _cartItemCubit =
      SetUpLocators.getIt<CartItemCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartItemCubit, CartItemsList>(
      bloc: _cartItemCubit,
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.cartItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final CartItemFormz cartItem = state.cartItems[index];

            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => _cartItemCubit.removeFromCart(
                cartItem,
              ),
              background: Container(
                color: kcErrorColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.delete, color: Colors.white),
                    horizontalSpace(10),
                  ],
                ),
              ),
              child: FoodCartItemWidget(cartItem),
            );
          },
        );
      },
    );
  }
}

class FoodCartItemWidget extends StatefulWidget {
  final CartItemFormz cartItem;

  const FoodCartItemWidget(this.cartItem, {super.key});

  @override
  State<FoodCartItemWidget> createState() => _FoodCartItemWidgetState();
}

class _FoodCartItemWidgetState extends State<FoodCartItemWidget> {
  final CartItemCubit _cartItemCubit = SetUpLocators.getIt<CartItemCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageWidget(
                height: h(70),
                width: w(65),
                imageTypes: ImageTypes.network,
                imageUrl: widget.cartItem.images.first.value,
              ),
            ),
            horizontalSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    widget.cartItem.name.value,
                    fontSize: sp(16),
                    fontWeight: FontWeight.w500,
                  ),
                  verticalSpace(5),
                  TextWidget(
                    currencyFormatter(widget.cartItem.price.value),
                    fontSize: sp(14),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            verticalSpace(10),
            CartItemCounterWidget(
              count: widget.cartItem.quantity.value,
              onIncrement: () {
                _cartItemCubit.increaseQuantity(widget.cartItem);
              },
              onDecrement: () {
                _cartItemCubit.decreaseQuantity(widget.cartItem);
              },
            ),
          ],
        ),
        verticalSpace(),
        if (widget.cartItem.extras.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.cartItem.extras.length,
            itemBuilder: (context, index) {
              final MenuExtraEntity extra = widget.cartItem.extras[index];
              return Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      '${extra.name} x ${extra.quantity}',
                      fontSize: sp(14),
                    ),
                  ),
                  TextWidget(
                    currencyFormatter(extra.price * extra.quantity),
                    fontSize: sp(14),
                  ),
                ],
              );
            },
          ),
        verticalSpace(3),
        Row(
          children: [
            Expanded(child: TextWidget("Total", fontSize: sp(14))),
            TextWidget(
              currencyFormatter(widget.cartItem.getTotal),
              fontSize: sp(14),
            ),
          ],
        ),
        verticalSpace(3),
        Divider(color: kcSoftTextColor.withOpacity(0.5)),
      ],
    );
  }
}
