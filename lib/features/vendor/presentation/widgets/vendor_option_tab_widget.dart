import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/constants/color.dart';
import 'tab_options/vendor_about_info_widget.dart';
import 'tab_options/vendor_menu_item_list_widget.dart';

class VendorOptionTabWidget extends StatelessWidget {
  const VendorOptionTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              indicatorColor: kcPrimaryColor,
              unselectedLabelColor: kcSoftTextColor.withOpacity(0.5),
              tabs: const <Widget>[
                Tab(child: TextWidget('Menu')),
                Tab(child: TextWidget('Reviews')),
                Tab(child: TextWidget('About')),
              ],
            ),
            const Flexible(
              child: TabBarView(
                children: <Widget>[
                  VendorMenuItemListWidget(),
                  SizedBox(),
                  VendorAboutInfoWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
