import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../../../home/domain/entities/menu_item_entity.dart';
import '../widgets/menu_item_details_widget/menu_image_widget.dart';
import '../widgets/menu_item_details_widget/menu_item_info_widget.dart';

class MenuItemDetailsView extends StatelessWidget {
  static const String route = '/menu-item-details-view';
  final MenuItemEntity menuItem;

  const MenuItemDetailsView(this.menuItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      usePadding: false,
      body: Column(
        children: <Widget>[
          MenuItemImageWidget(menuItem.images),
          Container(
            padding: EdgeInsets.symmetric(horizontal: w(15)),
            color: Colors.white,
            child: MenuItemInfoWidget(menuItem),
          ),
        ],
      ),
    );
  }
}
