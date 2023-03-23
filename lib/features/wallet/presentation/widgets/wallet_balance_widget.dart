import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/utils.dart';

class WalletBalanceWidget extends StatelessWidget {
  const WalletBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kcPrimaryColor.withOpacity(0.7),
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(sr(30)),
        //   bottomRight: Radius.circular(sr(30)),
        // ),
        borderRadius: BorderRadius.circular(sr(15)),
      ),
      child: _buildWalletItem(20393),
    );
  }

  Widget _buildWalletItem(double balance) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(15)),
      margin: EdgeInsets.symmetric(vertical: w(20)),
      child: SizedBox(
        width: sw(100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            verticalSpace(10),
            TextWidget("Total Balance", textColor: kcWhite, fontSize: sp(14)),
            TextWidget(
              currencyFormatter(balance),
              textColor: kcWhite,
              fontSize: sp(32),
              fontWeight: FontWeight.w600,
            ),
            verticalSpace(30),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: _buildWalletButtonWidget(
                    "assets/images/wallet/request_money.png",
                    "Receive",
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: _buildWalletButtonWidget(
                    "assets/images/wallet/send_money.png",
                    "Send",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _buildWalletButtonWidget(String iconPath, String name) {
    return Container(
      width: w(130),
      padding: EdgeInsets.symmetric(horizontal: w(5), vertical: h(10)),
      decoration: BoxDecoration(
        color: kcWhite.withOpacity(0.8),
        borderRadius: BorderRadius.circular(sr(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ImageWidget(
            imageUrl: iconPath,
            imageTypes: ImageTypes.asset,
            height: h(20),
            width: w(20),
          ),
          horizontalSpace(5),
          TextWidget(name, fontSize: sp(14)),
        ],
      ),
    );
  }
}
