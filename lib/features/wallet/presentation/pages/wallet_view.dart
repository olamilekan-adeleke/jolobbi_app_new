import 'package:flutter/material.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../bloc/get_transaction/get_transaction_bloc.dart';
import '../bloc/get_wallet/get_wallet_bloc.dart';
import '../bloc/log_trans/log_trans_bloc.dart';
import '../widgets/transaction_history_list_view_widget.dart';
import '../widgets/wallet_balance_widget.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final LogTransBloc _logTransBloc = SetUpLocators.getIt<LogTransBloc>();
  final GetWalletBloc _getWalletBloc = SetUpLocators.getIt<GetWalletBloc>();
  final GetTransactionBloc _getTransactionBloc =
      SetUpLocators.getIt<GetTransactionBloc>();

  @override
  void initState() {
    _getWalletBloc.add(const GetWalletEvent());
    _getTransactionBloc.add(const GetTransactionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getWalletBloc.add(const GetWalletEvent());
        _getTransactionBloc.add(const GetTransactionEvent());
      },
      child: ScaffoldWidget(
        body: Column(
          children: [
            verticalSpace(),
            const WalletBalanceWidget(),
            verticalSpace(20),
            const TransactionHistoryListViewWidget(),
          ],
        ),
      ),
    );
  }
}
