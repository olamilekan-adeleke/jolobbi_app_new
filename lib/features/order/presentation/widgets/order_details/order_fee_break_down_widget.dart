import 'package:flutter/material.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../domain/entities/order_entity.dart';

class OrderBreakDownWidget extends StatelessWidget {
  final OrderEntity order;
  const OrderBreakDownWidget(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(
          "Recept Breakdown",
          fontWeight: FontWeight.w500,
          fontSize: sp(18),
        ),
        verticalSpace(5),
        _buildBreakDownWidget("Discount", 0),
        _buildBreakDownWidget("Vat", 0),
        _buildBreakDownWidget("Delivery Fee", order.deliveryFee),
        _buildBreakDownWidget("Service Fee", order.serviceFee),
        _buildBreakDownWidget("Total", order.totalFee),
      ],
    );
  }

  Column _buildBreakDownWidget(String title, int amount) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextWidget(title, fontSize: sp(14), fontWeight: FontWeight.w300),
            TextWidget(
              currencyFormatter(amount),
              fontSize: sp(14),
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        verticalSpace(5),
      ],
    );
  }
}
