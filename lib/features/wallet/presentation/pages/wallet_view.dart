import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getWalletBloc.add(const GetWalletEvent());
      _getTransactionBloc.add(const GetTransactionEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getWalletBloc.add(const GetWalletEvent());
        _getTransactionBloc.add(const GetTransactionEvent());
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<LogTransBloc, LogTransState>(
            bloc: _logTransBloc,
            listener: logListener,
          ),
        ],
        child: ScaffoldWidget(
          body: Column(
            children: [
              verticalSpace(20),
              const WalletBalanceWidget(),
              verticalSpace(20),
              const TransactionHistoryListViewWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

extension on _WalletViewState {
  Future<void> logListener(context, LogTransState state) async {
    if (state is LogTransSuccess) {
      SnackBarService.showSuccessSnackBar(
        context: context,
        message: 'Payment successful',
      );

      await Future.delayed(const Duration(milliseconds: 1500));
      _getWalletBloc.add(const GetWalletEvent());
      _getTransactionBloc.add(const GetTransactionEvent());
    } else if (state is LogTransError) {
      SnackBarService.showErrorSnackBar(
        context: context,
        message: state.message,
      );
    }
  }
}
