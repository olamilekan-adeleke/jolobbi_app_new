import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/constants/color.dart';
import '../../../home/domain/entities/shop_details_entity.dart';
import 'tab_options/vendor_about_info_widget.dart';
import 'tab_options/vendor_menu_drink_items_widget.dart';
import 'tab_options/vendor_menu_item_list_widget.dart';

class VendorOptionTabWidget extends StatelessWidget {
  final ShopDetailsEntity shop;

  const VendorOptionTabWidget(this.shop, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              indicatorColor: kcPrimaryColor,
              unselectedLabelColor: kcSoftTextColor.withOpacity(0.5),
              tabs: const <Widget>[
                Tab(child: TextWidget('Menu')),
                Tab(child: TextWidget('Drink')),
                Tab(child: TextWidget('Reviews')),
                Tab(child: TextWidget('About')),
              ],
            ),
            Flexible(
              child: TabBarView(
                children: <Widget>[
                  VendorMenuItemListWidget(shop.id),
                  VendorMenuDrinkItemListWidget(shop.id),
                  // const SizedBox(),
                  const SizedBox(),
                  VendorAboutInfoWidget(shop),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
