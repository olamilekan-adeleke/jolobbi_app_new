// import 'dart:io';

// import 'package:flutter/material.dart';
// // import 'package:flutter_paystack/flutter_paystack.dart';

// class PaystackHelper {
//   const PaystackHelper._();
//   static PaystackHelper instance = const PaystackHelper._();

//   factory PaystackHelper() => instance;

//   static const String _publicKey =
//       "pk_test_783f909da670ff1ad0ec676ef617ead054d113e8";
//   // static final PaystackPlugin _plugin = PaystackPlugin();
//   // PaystackPlugin get plugin => _plugin;

//   // void setUp() => plugin.initialize(publicKey: _publicKey);

//   chargeCard({required BuildContext context, required amount}) async {
//     // Charge charge = Charge();
//     // charge.card = _getCardFromUI();

//     // charge
//     //   ..amount = 10000
//     //   ..email = 'customer@email.com'
//     //   ..reference = _getReference()
//     //   ..putCustomField('Charged From', 'Flutter SDK');

//     // final CheckoutResponse response = await plugin.chargeCard(
//     //   context,
//     //   charge: charge,
//     // );

//     // final String? reference = response.reference;

//     // if (response.status) {
//     //   _verifyOnServer(reference);
//     // }
//   }

//   String _fetchAccessCodeFrmServer(String reference) {
//     String accessCode = '/new-access-code';

//     return accessCode;
//   }

//   void _verifyOnServer(String? reference) async {
//     // _updateStatus(reference, 'Verifying...');
//     // String url = '$backendUrl/verify/$reference';
//     // try {
//     //   http.Response response = await http.get(Uri.parse(url));
//     //   var body = response.body;
//     //   _updateStatus(reference, body);
//     // } catch (e) {
//     //   _updateStatus(
//     //       reference,
//     //       'There was a problem verifying %s on the backend: '
//     //       '$reference $e');
//     // }
//     // setState(() => _inProgress = false);
//   }

//   String _getReference() {
//     String platform;
//     if (Platform.isIOS) {
//       platform = 'iOS';
//     } else {
//       platform = 'Android';
//     }

//     return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
//   }

//   // PaymentCard _getCardFromUI() {
//   //   // Using just the must-required parameters.
//   //   return PaymentCard(
//   //     number: null,
//   //     cvc: null,
//   //     expiryMonth: null,
//   //     expiryYear: null,
//   //     name: 'Segun Chukwuma Adamu',
//   //     country: 'Nigeria',
//   //     addressLine1: 'Ikeja, Lagos',
//   //   );

//     // Using Cascade notation (similar to Java's builder pattern)
// //    return PaymentCard(
// //        number: cardNumber,
// //        cvc: cvv,
// //        expiryMonth: expiryMonth,
// //        expiryYear: expiryYear)
// //      ..name = 'Segun Chukwuma Adamu'
// //      ..country = 'Nigeria'
// //      ..addressLine1 = 'Ikeja, Lagos'
// //      ..addressPostalCode = '100001';

//     // Using optional parameters
// //    return PaymentCard(
// //        number: cardNumber,
// //        cvc: cvv,
// //        expiryMonth: expiryMonth,
// //        expiryYear: expiryYear,
// //        name: 'Ismail Adebola Emeka',
// //        addressCountry: 'Nigeria',
// //        addressLine1: '90, Nnebisi Road, Asaba, Deleta State');
//   // }
// }
