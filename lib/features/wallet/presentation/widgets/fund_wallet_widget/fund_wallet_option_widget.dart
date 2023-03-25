import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/navigator/navigator.dart';
import '../../../../../cores/utils/formatter/money_formatter.dart';
import '../../../../../cores/utils/formz_validator/payment_option.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../data/models/flutter_wave_payment_model.dart';
import '../../bloc/log_trans/log_trans_bloc.dart';
import '../../cubit/fund_wallet_cubit.dart';
import '../../pages/payment_gateway_screen/flutter_wave_payment_view.dart';
import '../../pages/payment_gateway_screen/paystack_payment_view.dart';

class FundWalletOptionWidget extends StatefulWidget {
  const FundWalletOptionWidget({super.key});

  @override
  State<FundWalletOptionWidget> createState() => _FundWalletOptionWidgetState();
}

class _FundWalletOptionWidgetState extends State<FundWalletOptionWidget> {
  final FundWalletCubit _cubit = SetUpLocators.getIt<FundWalletCubit>();
  final LogTransBloc _logTransBloc = SetUpLocators.getIt<LogTransBloc>();

  @override
  void initState() {
    _cubit.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        verticalSpace(20),
        TextWidget(
          "Payment Amount",
          fontSize: sp(18),
          fontWeight: FontWeight.w600,
        ),
        TextWidget(
          "Enter the amount you want to fund your wallet",
          fontSize: sp(16),
          textColor: kcSoftTextColor.withOpacity(0.5),
        ),
        verticalSpace(),
        TextFieldWidget(
          hintText: "\u20A6 1,000",
          validator: amountValidator,
          textInputType: const TextInputType.numberWithOptions(),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyTextInputFormatter(symbol: "\u20A6 "),
          ],
          onChanged: _cubit.amountChanged,
        ),
        verticalSpace(25),
        TextWidget(
          "Payment Method",
          fontSize: sp(18),
          fontWeight: FontWeight.w600,
        ),
        TextWidget(
          "Select a payment method to fund your wallet",
          fontSize: sp(16),
          textColor: kcSoftTextColor.withOpacity(0.5),
        ),
        verticalSpace(25),
        BlocBuilder<FundWalletCubit, FundWalletFormz>(
          bloc: _cubit,
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _cubit.paymentOptionChanged(
                    PaymentOption.flutterWave,
                  ),
                  child: _BuildWalletButtonWidget(
                    image: "assets/icons/wallet/flutterwave.png",
                    title: "Flutterwave",
                    description: "Pay with your debit card",
                    selected: state.getOption == PaymentOption.flutterWave,
                  ),
                ),
                verticalSpace(15),
                GestureDetector(
                  onTap: () => _cubit.paymentOptionChanged(
                    PaymentOption.paystack,
                  ),
                  child: _BuildWalletButtonWidget(
                    image: "assets/icons/wallet/paystack.png",
                    title: "Paystack",
                    description: "Pay with your debit card",
                    selected: state.getOption == PaymentOption.paystack,
                  ),
                ),
              ],
            );
          },
        ),
        verticalSpace(50),
        BlocBuilder<LogTransBloc, LogTransState>(
          bloc: _logTransBloc,
          builder: (context, state) {
            if (state is LogTransLoading) {
              return const Button.loading();
            }

            return BlocBuilder<FundWalletCubit, FundWalletFormz>(
              bloc: _cubit,
              builder: (context, state) {
                return Button(
                  active: state.isValid,
                  text: "Fund Wallet",
                  onTap: () {
                    final args = FlutterWavePaymentArgs(
                      amount: state.amount.value,
                      currency: "ng",
                      transactionRef: "${DateTime.now().microsecond}_tr",
                      description: "Payment for Jolobbi",
                      email: "olamilekanly66@gmail.com",
                      fullName: "Kod Enigma",
                      phoneNumber: "08100000000",
                    );

                    if (state.getOption == PaymentOption.flutterWave) {
                      openFlutterWave(args);
                    } else if (state.getOption == PaymentOption.paystack) {
                      openPaystackWave(args);
                    }
                  },
                );
              },
            );
          },
        ),
        verticalSpace(),
      ],
    );
  }

  Future<void> openFlutterWave(FlutterWavePaymentArgs args) async {
    final FlutterWavePaymentModel? model = await AppRouter.instance.navigateTo(
      FlutterWavePaymentView.routeName,
      arguments: args,
    );

    if (model == null) {
      SnackBarService.showErrorSnackBar(
        context: context,
        message: "Payment Failed, Unable to make payment",
      );
      return;
    }

    // Todo: Process payment
  }

  Future<void> openPaystackWave(FlutterWavePaymentArgs args) async {
    final CheckoutResponse? response = await AppRouter.instance.navigateTo(
      PaystackPaymentView.routeName,
      arguments: args,
    );

    if (response == null) {
      SnackBarService.showErrorSnackBar(
        context: context,
        message: "Payment Failed, Unable to make payment",
      );
      return;
    }

    // Todo: Process payment
  }
}

class _BuildWalletButtonWidget extends StatelessWidget {
  const _BuildWalletButtonWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.selected,
  }) : super(key: key);

  final String image;
  final String title;
  final String description;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(sr(10)),
          child: ImageWidget(
            imageUrl: image,
            imageTypes: ImageTypes.asset,
            width: w(45),
            height: w(45),
          ),
        ),
        horizontalSpace(5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              title,
              fontSize: sp(16),
              fontWeight: FontWeight.w600,
            ),
            TextWidget(
              description,
              fontSize: sp(15),
              textColor: kcSoftTextColor.withOpacity(0.5),
            ),
          ],
        ),
        const Spacer(),
        AbsorbPointer(
          absorbing: true,
          child: Radio(
            value: selected,
            groupValue: true,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
