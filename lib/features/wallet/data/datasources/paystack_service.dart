import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import '../../../../cores/utils/env/evn.dart';
import '../../presentation/pages/payment_gateway_screen/flutter_wave_payment_view.dart';

class PaystackService {
  static final _plugin = PaystackPlugin();

  void init() {
    _plugin.initialize(publicKey: ENV.paystackPublicKey);
  }

  Future<CheckoutResponse> chargeCard(
    BuildContext context,
    FlutterWavePaymentArgs args,
  ) async {
    Charge charge = Charge()
      ..amount = args.amount * 100
      ..reference = _getReference(args)
      ..email = args.email;

    CheckoutResponse response = await _plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
      fullscreen: true,
    );

    return response;
  }

  String _getReference(FlutterWavePaymentArgs args) => args.transactionRef;
}
