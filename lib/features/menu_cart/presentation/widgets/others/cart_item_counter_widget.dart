import 'package:flutter/material.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/utils.dart';

class CartItemCounterWidget extends StatelessWidget {
  const CartItemCounterWidget({
    Key? key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(5)),
      decoration: BoxDecoration(
        border: Border.all(color: kcGrey400),
        borderRadius: BorderRadius.circular(sr(5)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Icon(
              Icons.remove_circle_outline_outlined,
              color: kcPrimaryColor,
              size: sr(20),
            ),
          ),
          horizontalSpace(),
          TextWidget("$count", fontSize: sp(14)),
          horizontalSpace(),
          GestureDetector(
            onTap: onDecrement,
            child: Icon(
              Icons.add_circle_outline_outlined,
              color: kcPrimaryColor,
              size: sr(20),
            ),
          ),
        ],
      ),
    );
  }
}
