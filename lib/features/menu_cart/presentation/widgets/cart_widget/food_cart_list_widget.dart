import 'package:flutter/material.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/utils.dart';
import '../others/cart_item_counter_widget.dart';

class FoodCartListWidget extends StatelessWidget {
  const FoodCartListWidget({super.key});

  get kcWhiteColor => null;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
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
          child: const FoodCartItemWidget(),
        );
      },
    );
  }
}

class FoodCartItemWidget extends StatelessWidget {
  final bool isEditable;

  const FoodCartItemWidget({super.key, this.isEditable = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageWidget(
                height: h(isEditable ? 70 : 45),
                width: w(isEditable ? 65 : 45),
                imageTypes: ImageTypes.network,
                imageUrl:
                    "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
              ),
            ),
            horizontalSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    "Chicken Burger",
                    fontSize: sp(16),
                    fontWeight: FontWeight.w500,
                  ),
                  verticalSpace(isEditable ? 5 : 0),
                  TextWidget(
                    currencyFormatter(2300),
                    fontSize: sp(14),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            verticalSpace(10),
            if (isEditable)
              CartItemCounterWidget(
                count: 1,
                onIncrement: () {},
                onDecrement: () {},
              ),
          ],
        ),
        verticalSpace(),
        if (isEditable)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(child: TextWidget("Extra Cheese", fontSize: sp(14))),
                  TextWidget(currencyFormatter(200), fontSize: sp(14)),
                ],
              );
            },
          ),
        if (isEditable) Divider(color: kcSoftTextColor.withOpacity(0.5)),
      ],
    );
  }
}
