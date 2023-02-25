import 'package:flutter/material.dart';

import '../../../../cores/components/box_shadow.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/sizer_utils.dart';

class VendorShopInfoWidget extends StatelessWidget {
  const VendorShopInfoWidget({super.key});

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
              imageUrl:
                  'https://businessday.ng/wp-content/uploads/2021/03/Burger-King.jpeg',
              height: h(200),
              width: sw(100),
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
                    'Burger King',
                    fontSize: sp(22),
                    fontWeight: FontWeight.w600,
                  ),
                  TextWidget(
                    '542 5th Ave, New York, NY 10036, USA',
                    fontSize: sp(14),
                    textColor: kcSoftTextColor.withOpacity(0.5),
                  ),
                  verticalSpace(5),
                  TextWidget(
                    'Open 10:00 AM - 10:00 PM',
                    fontSize: sp(14),
                    textColor: Colors.green.withOpacity(0.7),
                  ),
                  verticalSpace(5),
                  TextWidget(
                    'Chinese • Fast Food • Burger • Pizza',
                    fontSize: sp(14),
                  ),
                  verticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.star, color: kcPrimaryColor, size: w(15)),
                      horizontalSpace(3),
                      TextWidget(
                        '4.5',
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
                        '2975 Reviews',
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
