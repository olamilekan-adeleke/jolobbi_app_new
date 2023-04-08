import 'package:flutter/material.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../../home/domain/entities/menu_item_entity.dart';
import '../../../domain/entities/order_entity.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderEntity order;
  const OrderItemWidget(this.order, {super.key});

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
          itemCount: order.items.length,
          itemBuilder: (context, index) => FoodCartItemWidget(
            order.items[index],
          ),
        ),
      ],
    );
  }
}

class FoodCartItemWidget extends StatelessWidget {
  final OrderItemEntity item;

  const FoodCartItemWidget(this.item, {super.key});

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
                imageUrl: item.images.first,
              ),
            ),
            horizontalSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    item.name,
                    fontSize: sp(16),
                    fontWeight: FontWeight.w500,
                  ),
                  verticalSpace(5),
                  TextWidget(
                    currencyFormatter(item.price),
                    fontSize: sp(14),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            verticalSpace(10),
          ],
        ),
        verticalSpace(),
        if (item.extras.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: item.extras.length,
            itemBuilder: (context, index) {
              final MenuExtraEntity extra = item.extras[index];
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
              currencyFormatter(item.getTotal),
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
