// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../data/datasources/paystack_service.dart';
import 'flutter_wave_payment_view.dart';

class PaystackPaymentView extends StatefulWidget {
  static const String routeName = '/paystackPaymentView';

  final FlutterWavePaymentArgs args;
  const PaystackPaymentView(this.args, {super.key});

  @override
  State<PaystackPaymentView> createState() => _PaystackPaymentViewState();
}

class _PaystackPaymentViewState extends State<PaystackPaymentView> {
  final PaystackService _paystackService =
      SetUpLocators.getIt<PaystackService>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => startPayment());
    super.initState();
  }

  void startPayment() async {
    final response = await _paystackService.chargeCard(context, widget.args);
    LoggerHelper.log(response.toString());

    if (response.status) {
      Navigator.pop(context, response);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return false;
      },
      child: ScaffoldWidget(
        usePadding: false,
        useSingleScroll: false,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sp(kGlobalPadding)),
              child: const AppBarWidget("FlutterWave Gateway"),
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
