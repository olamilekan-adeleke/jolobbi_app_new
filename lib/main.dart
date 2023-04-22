import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/app.dart';
import 'app/locator.dart';
// import 'cores/push_notification/push_nofication_helper.dart';
import 'features/wallet/data/datasources/paystack_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SetUpLocators.init();
  await dotenv.load(fileName: "assets/.env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  // SetUpLocators.getIt<PushNotificationHelper>().initNotification();
  SetUpLocators.getIt<PaystackService>().init();

  runApp(const MyApp());
}
