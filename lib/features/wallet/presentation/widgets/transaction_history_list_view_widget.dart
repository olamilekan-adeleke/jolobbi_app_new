import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/utils.dart';
import '../../domain/entities/transaction_entity.dart';
import '../bloc/get_transaction/get_transaction_bloc.dart';

class TransactionHistoryListViewWidget extends StatefulWidget {
  const TransactionHistoryListViewWidget({super.key});

  @override
  State<TransactionHistoryListViewWidget> createState() =>
      _TransactionHistoryListViewWidgetState();
}

class _TransactionHistoryListViewWidgetState
    extends State<TransactionHistoryListViewWidget> {
  final GetTransactionBloc _getTransactionBloc =
      SetUpLocators.getIt<GetTransactionBloc>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              'Transaction History',
              fontSize: sp(18),
              fontWeight: FontWeight.w700,
            ),
            TextWidget(
              'See all',
              fontSize: sp(16),
              textColor: kcPrimaryColor,
              decoration: TextDecoration.underline,
            ),
          ],
        ),
        verticalSpace(),
        BlocBuilder<GetTransactionBloc, GetTransactionState>(
          bloc: _getTransactionBloc,
          builder: (context, state) {
            if (state is GetTransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetTransactionError) {
              return SizedBox(
                height: sh(30),
                child: CustomErrorWidget(
                  useFlex: false,
                  message: state.message,
                  onRetry: () => _getTransactionBloc.add(
                    const GetTransactionEvent(),
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: h(20)),
              separatorBuilder: (context, index) => const Divider(),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _getTransactionBloc.transactionsList.length,
              itemBuilder: (context, index) {
                final transaction = _getTransactionBloc.transactionsList[index];

                return TransactionItem(transaction);
              },
            );
          },
        ),
      ],
    );
  }
}

class TransactionItem extends StatelessWidget {
  final TransactionEntity transaction;
  const TransactionItem(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: transaction.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: RotatedBox(
            quarterTurns: transaction.rotation,
            child: Icon(CupertinoIcons.paperplane, size: sp(20)),
          ),
        ),
        horizontalSpace(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(
                transaction.title,
                fontSize: sp(16),
                fontWeight: FontWeight.w600,
              ),
              verticalSpace(2),
              TextWidget(
                transaction.description,
                fontSize: sp(14),
                textColor: kcSoftTextColor.withOpacity(0.5),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        TextWidget(
          '${transaction.sign} ${currencyFormatter(transaction.amount)}',
          fontSize: sp(16),
          fontWeight: FontWeight.w500,
          textColor: transaction.color,
        ),
      ],
    );
  }
}
