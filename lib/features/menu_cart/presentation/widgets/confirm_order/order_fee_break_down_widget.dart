import 'package:flutter/material.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';

import '../../../../../cores/utils/utils.dart';

class OrderBreakDownWidget extends StatelessWidget {
  const OrderBreakDownWidget({super.key});

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
        _buildBreakDownWidget("Vat (2.00%)", 0),
        _buildBreakDownWidget("Delivery Fee", 600),
        _buildBreakDownWidget("Subtotal", 2450),
        Divider(color: kcSoftTextColor.withOpacity(0.5)),
        _buildBreakDownWidget("Total", 3100),
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
