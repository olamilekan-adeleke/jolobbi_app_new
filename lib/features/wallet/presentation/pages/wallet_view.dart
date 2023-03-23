import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../widgets/transaction_history_list_view_widget.dart';
import '../widgets/wallet_balance_widget.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: [
          verticalSpace(),
          const WalletBalanceWidget(),
          verticalSpace(20),
          const TransactionHistoryListViewWidget(),
        ],
      ),
    );
  }
}
