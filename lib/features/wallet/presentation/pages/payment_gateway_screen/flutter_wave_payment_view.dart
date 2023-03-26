import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jolobbi_app_new/cores/constants/font_size.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/utils/env/evn.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../data/models/flutter_wave_payment_model.dart';

class FlutterWavePaymentView extends StatefulWidget {
  static const String routeName = '/flutterWavePaymentView';

  final FlutterWavePaymentArgs args;
  const FlutterWavePaymentView(this.args, {super.key});

  @override
  State<FlutterWavePaymentView> createState() => _FlutterWavePaymentViewState();
}

class _FlutterWavePaymentViewState extends State<FlutterWavePaymentView> {
  String contentBase64 = '';
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    contentBase64 = base64Encode(const Utf8Encoder().convert(_buildHtml()));
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        'Print',
        onMessageReceived: (JavaScriptMessage message) {
          LoggerHelper.log(message.message);

          if (message.message == 'close') {
            LoggerHelper.log('close');
            Navigator.pop(context, false);
            //modal close untimely, do not
          } else {
            LoggerHelper.log("success message");
            final decode = json.decode(message.message);
            LoggerHelper.log(decode.toString());
            handleResponse(decode);
          }
        },
      )
      ..loadHtmlString(_buildHtml());
    // setUpChannel();
  }

  // Future<void> setUpChannel() async {
  //   final Customer customer = Customer(
  //     name: widget.args.fullName,
  //     phoneNumber: widget.args.phoneNumber,
  //     email: widget.args.email,
  //   );

  //   final Flutterwave flutterwave = Flutterwave(
  //     context: context,
  //     publicKey: ENV.flutterWavePublicKey,
  //     currency: "NGN",
  //     redirectUrl: "",
  //     txRef: widget.args.transactionRef,
  //     amount: widget.args.amount.toString(),
  //     customer: customer,
  //     paymentOptions: "ussd, card, barter, bank",
  //     customization: Customization(title: "My Payment"),
  //     isTestMode: true,
  //   );

  //   final ChargeResponse response = await flutterwave.charge();

  //   LoggerHelper.log(response.toJson());
  // }

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
            Expanded(child: WebViewWidget(controller: _controller)),
          ],
        ),
      ),
    );
  }

  void handleResponse(Map<String, dynamic> body) {
    if (body['status'] == "successful") {
      FlutterWavePaymentModel model = FlutterWavePaymentModel.fromMap(body);
      return Navigator.pop(context, model);
    } else {
      return Navigator.pop(context);
    }
  }

  String _buildHtml() {
    return ''' <!DOCTYPE html>
    <html lang="en">
        <head>
          <meta charset="UTF-8">
          <meta http-equiv="X-UA-Compatible" content="ie=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Flutterwave Payment</title>
          <script src="https://checkout.flutterwave.com/v3.js"></script>
        </head>
        <body onload="makePayment" style="background-color:#fff;height:100vh;overflow: scroll;">
          <!-- <form>
            <script src="https://checkout.flutterwave.com/v3.js"></script>
            <button type="button" onClick="alert('here we are')">Pay Now</button>
          </form> -->
          <script>
            window.onload = makePayment();
            function makePayment() { 
              FlutterwaveCheckout({
                public_key: "${ENV.flutterWavePublicKey}",
                tx_ref: "${widget.args.transactionRef}",
                amount: "${widget.args.amount}",
                currency: "NGN",
                country: "NG",
                payment_options: "card",
                // redirect_url:    "https://webhook.dev.ajobox.com?m=card",
                customer: {
                  email: "${widget.args.email}",
                  phone_number: "${widget.args.phoneNumber}",
                  name: "${widget.args.fullName}",
                },
                callback: function (data) {
                  console.log(data);
                  Print.postMessage(JSON.stringify(data))
                },
                onclose: function() {
                  // close modal
                  Print.postMessage("close")
                },
                customizations: {
                  title: "Jolobbi",
                  description: '${widget.args.description}',
                },
              });
            }
          </script>
        </body>
    </html>''';
  }
}

class FlutterWavePaymentArgs {
  FlutterWavePaymentArgs({
    required this.transactionRef,
    required this.amount,
    required this.currency,
    required this.description,
    required this.email,
    required this.phoneNumber,
    required this.fullName,
  });

  final String transactionRef;
  final int amount;
  final String currency;
  final String description;
  final String email;
  final String phoneNumber;
  final String fullName;
}
