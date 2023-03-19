import 'package:flutter/material.dart';

import '../../../../../../cores/components/components.dart';
import '../../../../../../cores/constants/constants.dart';
import '../../../../../../cores/utils/utils.dart';
import '../../../../home/domain/entities/menu_item_entity.dart';

class MenuItemNameAndPriceWidget extends StatelessWidget {
  final MenuItemEntity menuItem;
  const MenuItemNameAndPriceWidget(this.menuItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: sw(68),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    menuItem.name,
                    fontSize: sp(20),
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: kcPrimaryColor, size: sp(15)),
                      TwoSpanTextWidget(
                        " ${menuItem.rating} (${menuItem.ratingCount}) ",
                        "Burger King",
                        fontSize: sp(16),
                        fontSize2: sp(14),
                        fontWeight: FontWeight.w500,
                        fontWeight2: FontWeight.w300,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextWidget(
              currencyFormatter(menuItem.price),
              fontSize: sp(24),
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }
}
