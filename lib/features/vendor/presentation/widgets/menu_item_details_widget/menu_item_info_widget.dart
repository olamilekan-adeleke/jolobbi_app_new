import 'package:flutter/material.dart';
import '../../../../../cores/utils/utils.dart';

import '../../../../home/domain/entities/menu_item_entity.dart';
import 'menu_item_description_and_review_widget.dart';
import 'menu_item_name_and_price_widget.dart';

class MenuItemInfoWidget extends StatelessWidget {
  final MenuItemEntity menuItem;

  const MenuItemInfoWidget(this.menuItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verticalSpace(5),
        MenuItemNameAndPriceWidget(menuItem),
        MenuItemDescriptionWidget(menuItem),
      ],
    );
  }
}
