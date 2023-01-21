import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/locator.dart';
import 'cores/push_notification/push_nofication_helper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SetUpLocators.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SetUpLocators.getIt<PushNotificationHelper>().initNotification();

  runApp(const MyApp());
}
