import 'package:flutter/material.dart';

import '../../../../cores/components/box_shadow.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../home/domain/entities/shop_details_entity.dart';

class VendorShopInfoWidget extends StatelessWidget {
  final ShopDetailsEntity shop;

  const VendorShopInfoWidget(this.shop, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kcGrey100,
      height: h(320),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ImageWidget(
              imageTypes: ImageTypes.network,
              imageUrl: shop.imageUrl,
              height: h(200),
              width: sw(100),
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: w(20), vertical: h(20)),
              padding: EdgeInsets.symmetric(vertical: w(20)),
              decoration: BoxDecoration(
                color: kcWhite,
                borderRadius: BorderRadius.circular(w(20)),
                boxShadow: boxShadowHelper,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  horizontalSpace(double.infinity),
                  TextWidget(
                    shop.name,
                    fontSize: sp(22),
                    fontWeight: FontWeight.w600,
                  ),
                  TextWidget(
                    shop.address,
                    fontSize: sp(14),
                    textColor: kcSoftTextColor.withOpacity(0.5),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(5),
                  TextWidget(
                    'Open 10:00 AM - 10:00 PM',
                    fontSize: sp(14),
                    textColor: Colors.green.withOpacity(0.7),
                  ),
                  verticalSpace(5),
                  TextWidget(
                    'Fast Food • Drinks',
                    fontSize: sp(14),
                  ),
                  verticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.star, color: kcPrimaryColor, size: w(15)),
                      horizontalSpace(3),
                      TextWidget(
                        shop.numberOfLikes.toString(),
                        fontSize: sp(14),
                        fontWeight: FontWeight.w600,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: w(5)),
                        height: h(10),
                        width: w(1),
                        color: kcGrey100,
                      ),
                      Icon(Icons.people, color: kcPrimaryColor, size: w(15)),
                      horizontalSpace(3),
                      TextWidget(
                        '${shop.numberOfReviews} Reviews',
                        fontSize: sp(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
