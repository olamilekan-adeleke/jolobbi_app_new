import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/utils.dart';

class TransactionHistoryListViewWidget extends StatelessWidget {
  const TransactionHistoryListViewWidget({super.key});

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
        ListView.separated(
          padding: EdgeInsets.symmetric(vertical: h(20)),
          separatorBuilder: (context, index) => const Divider(),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return const TransactionItem();
          },
        ),
      ],
    );
  }
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: kcPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: RotatedBox(
            quarterTurns: 2,
            child: Icon(CupertinoIcons.paperplane, size: sp(20)),
          ),
        ),
        horizontalSpace(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(
                'Fund transfer',
                fontSize: sp(16),
                fontWeight: FontWeight.w600,
              ),
              verticalSpace(2),
              TextWidget(
                'Transaction description',
                fontSize: sp(14),
                textColor: kcSoftTextColor.withOpacity(0.5),
              ),
            ],
          ),
        ),
        TextWidget(
          '- ${currencyFormatter(100)}',
          fontSize: sp(16),
          fontWeight: FontWeight.w500,
          textColor: kcErrorColor,
        ),
      ],
    );
  }
}
