import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../data/models/order_model.dart';
import '../../../domain/entities/order_entity.dart';
import '../../bloc/confirm_make_payment/confirm_make_payment_bloc.dart';

class OrderPaymentMethodWidget extends StatelessWidget {
  final OrderEntity order;
  const OrderPaymentMethodWidget(this.order, {super.key});

  static final ConfirmMakePaymentBloc _makePaymentBloc =
      SetUpLocators.getIt<ConfirmMakePaymentBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConfirmMakePaymentBloc, ConfirmMakePaymentState>(
      bloc: _makePaymentBloc,
      listener: (context, state) {
        if (state is ConfirmMakePaymentSuccess) {
          SnackBarService.showSuccessSnackBar(
            message: state.entity.message,
            context: context,
          );
        } else if (state is ConfirmMakePaymentError) {
          SnackBarService.showErrorSnackBar(
            message: state.message,
            context: context,
          );
        }
      },
      child: SizedBox(
        width: sw(99),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  "Payment Method",
                  fontWeight: FontWeight.w500,
                  fontSize: sp(18),
                ),
                verticalSpace(5),
                TextWidget(
                  order.paymentMethod.getFormattedName,
                  fontSize: sp(18),
                  fontWeight: FontWeight.w400,
                  textColor: kcSoftTextColor.withOpacity(0.8),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            if (order.paymentMethod == OrderPaymentMethod.bankTransfer &&
                order.hasConfirmedBankTransfer != true)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    "Tap to confirm you have made payment",
                    fontSize: sp(18),
                    fontWeight: FontWeight.w400,
                    textColor: kcSoftTextColor.withOpacity(0.5),
                    textAlign: TextAlign.start,
                  ),
                  verticalSpace(),
                  BlocBuilder<ConfirmMakePaymentBloc, ConfirmMakePaymentState>(
                    bloc: _makePaymentBloc,
                    builder: (context, state) {
                      if (state is ConfirmMakePaymentLoading) {
                        return const Button.loading();
                      }

                      return Button(
                        text: "I Have Made Payment",
                        onTap: () => _makePaymentBloc.add(
                          ConfirmMakePaymentEvent(order.orderId),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class OrderPaymentForBankTransferDetailWidget extends StatelessWidget {
  final OrderEntity order;
  const OrderPaymentForBankTransferDetailWidget(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sw(99),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                "Payment Detail",
                fontWeight: FontWeight.w500,
                fontSize: sp(18),
              ),
              TextWidget(
                "Please make payment to the following account",
                fontSize: sp(16),
                fontWeight: FontWeight.w400,
                textColor: kcSoftTextColor.withOpacity(0.8),
                textAlign: TextAlign.start,
              ),
              verticalSpace(15),
              TwoSpanTextWidget(
                "Bank Account: ",
                "Opay Microfinance Bank",
                fontSize: sp(14),
                fontSize2: sp(14),
                fontWeight: FontWeight.w400,
                fontWeight2: FontWeight.w500,
                textColor: kcSoftTextColor.withOpacity(0.8),
              ),
              TwoSpanTextWidget(
                "Account Name: ",
                "Jolobbi Foods",
                fontSize: sp(14),
                fontSize2: sp(14),
                fontWeight: FontWeight.w400,
                fontWeight2: FontWeight.w500,
                textColor: kcSoftTextColor.withOpacity(0.8),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TwoSpanTextWidget(
                    "Account Number: ",
                    "7052936789",
                    fontSize: sp(14),
                    fontSize2: sp(14),
                    fontWeight: FontWeight.w400,
                    fontWeight2: FontWeight.w500,
                    textColor: kcSoftTextColor.withOpacity(0.8),
                  ),
                  horizontalSpace(),
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(
                        const ClipboardData(text: "7052936789"),
                      );

                      SnackBarService.showSuccessSnackBar(
                        context: context,
                        message: "Account number copied",
                      );
                    },
                    child: Icon(
                      Icons.copy,
                      size: sp(15),
                      color: kcSoftTextColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
