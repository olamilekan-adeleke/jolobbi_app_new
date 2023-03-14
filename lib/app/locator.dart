import 'package:get_it/get_it.dart';
import 'package:jolobbi_app_new/features/home/home_locator.dart';

import '../cores/push_notification/push_nofication_helper.dart';
import '../features/Authentication/auth_locator.dart';

class SetUpLocators {
  static const SetUpLocators _instance = SetUpLocators._();
  const SetUpLocators._();
  factory SetUpLocators() => _instance;

  static final getIt = GetIt.instance;

  static void init() {
    _setUp();

    ///--------------- Authentication --------------------//
    setUpAuthenticationLocators();

    ///--------------- Home --------------------//
    setUpHomeLocator();
  }

  static void _setUp() {
    ///--------------- Push Notification --------------------//
    getIt.registerLazySingleton<PushNotificationHelper>(
      () => PushNotificationHelper(),
    );
  }
}
