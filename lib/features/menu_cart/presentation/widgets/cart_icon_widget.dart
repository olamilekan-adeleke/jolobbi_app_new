import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../cores/components/components.dart';

import '../../../../cores/utils/utils.dart';

class CartIconWidget extends StatelessWidget {
  const CartIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h(30),
      width: w(30),
      child: Stack(
        children: [
          Align(child: Icon(CupertinoIcons.shopping_cart, size: sp(23))),
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
                child: TextWidget(
                  "12",
                  fontSize: sp(14),
                  fontWeight: FontWeight.w500,
                  textColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
