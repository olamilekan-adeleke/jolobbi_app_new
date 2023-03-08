import 'package:flutter/cupertino.dart';
import '../../../../cores/utils/utils.dart';

import '../../../../cores/components/components.dart';
import '../widgets/vendor_option_tab_widget.dart';
import '../widgets/vendor_shop_info_widget.dart';

class VendorDetailsView extends StatelessWidget {
  static const String route = '/vendor-details';

  const VendorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const AppBarWidget(
            "Burger King",
            trilling: Icon(CupertinoIcons.cart),
            useSpacer: true,
          ),
          const VendorShopInfoWidget(),
          verticalSpace(5),
          const VendorOptionTabWidget(),
        ],
      ),
    );
  }
}
