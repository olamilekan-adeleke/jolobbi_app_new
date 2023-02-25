import 'package:flutter/material.dart';
import 'package:jolobbi_app_new/cores/components/components.dart';
import 'package:jolobbi_app_new/cores/utils/utils.dart';

import 'menu_item_description_and_review_widget.dart';
import 'menu_item_name_and_price_widget.dart';

class MenuItemInfoWidget extends StatelessWidget {
  const MenuItemInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verticalSpace(5),
        const MenuItemNameAndPriceWidget(),
        const MenuItemDescriptionWidget(),
      ],
    );
  }
}
