import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/utils.dart';
import '../bloc/get_wallet/get_wallet_bloc.dart';
import 'fund_wallet_widget/fund_wallet_option_widget.dart';

class WalletBalanceWidget extends StatelessWidget {
  const WalletBalanceWidget({super.key});

  static final GetWalletBloc _getWalletBloc =
      SetUpLocators.getIt<GetWalletBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kcPrimaryColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(sr(15)),
      ),
      child: BlocBuilder<GetWalletBloc, GetWalletState>(
        bloc: _getWalletBloc,
        builder: (context, state) {
          num balance = 0;
          if (state is GetWalletSuccess) {
            balance = state.wallet.balance;
          }

          return _buildWalletItem(context, balance);
        },
      ),
    );
  }

  Widget _buildWalletItem(BuildContext context, num balance) {
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
                  onTap: () => openFundAccount(context),
                  child: _buildWalletButtonWidget(
                    "assets/images/wallet/request_money.png",
                    "Fund",
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: _buildWalletButtonWidget(
                    "assets/images/wallet/send_money.png",
                    "Withdraw",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> openFundAccount(BuildContext context) async {
    BottomSheetHelper.show(context, child: const FundWalletOptionWidget());
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
