import 'package:flutter/cupertino.dart';
import '../../../../cores/utils/utils.dart';

import '../../../../cores/components/components.dart';
import '../../../home/domain/entities/shop_details_entity.dart';
import '../widgets/vendor_option_tab_widget.dart';
import '../widgets/vendor_shop_info_widget.dart';

class VendorDetailsView extends StatelessWidget {
  static const String route = '/vendor-details';
  final ShopDetailsEntity shop;

  const VendorDetailsView(this.shop, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppBarWidget(
            shop.name,
            trilling: const Icon(CupertinoIcons.cart),
            useSpacer: true,
          ),
          VendorShopInfoWidget(shop),
          verticalSpace(5),
          VendorOptionTabWidget(shop),
        ],
      ),
    );
  }
}
