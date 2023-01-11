// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:propertyapp/cores/components/app_bar_widget.dart';
// import 'package:propertyapp/cores/utils/sizer_utils.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// import '../components/custom_scaffold_widget.dart';

// class PaystackPaymentData {
//   final String authorizationUrl;
//   final String accessCode;
//   final String reference;

//   PaystackPaymentData({
//     required this.authorizationUrl,
//     required this.accessCode,
//     required this.reference,
//   });

//   factory PaystackPaymentData.fromMap(Map<String, dynamic> map) {
//     return PaystackPaymentData(
//       authorizationUrl: map['authorization_url'] as String,
//       accessCode: map['access_code'] as String,
//       reference: map['reference'] as String,
//     );
//   }
// }

// class PaystackPaymentWebView extends StatelessWidget {
//   final PaystackPaymentData paymentData;

//   const PaystackPaymentWebView(this.paymentData, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldWidget(
//       useSingleScroll: false,
//       usePadding: false,
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: sp(15)),
//             child: const AppBarWidget("Payment Page"),
//           ),
//           verticalSpace(20),
//           Flexible(
//             child: WebView(
//               initialUrl: paymentData.authorizationUrl,
//               javascriptMode: JavascriptMode.unrestricted,
//               userAgent: 'Flutter;Webview',
//               navigationDelegate: (navigation) {
//                 log(navigation.url);
//                 //Listen for callback URL
//                 if (navigation.url == "https://standard.paystack.co/close") {
//                   Navigator.of(context).pop(); //close webview

//                   // _txnRef is my glabally created variable to handle my reference
//                   // _txnRef = _ref;
//                   // _submit();
//                 }
//                 // if (navigation.url ==
//                 //     "github.com/gikwegbu?trxref=$_ref&reference=$_ref") {
//                 //   Navigator.of(context).pop();
//                 //   _txnRef = _ref;
//                 //   _submit();
//                 // }
//                 if (navigation.url == "https://www.google.com/") {
//                   Navigator.of(context).pop();
//                 }
//                 return NavigationDecision.navigate;
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
