import 'package:get_it/get_it.dart';
import 'package:jolobbi_app_new/features/home/home_locator.dart';

import '../cores/firebase_helper/firebase_helper.dart';
import '../cores/push_notification/push_nofication_helper.dart';
import '../features/Authentication/auth_locator.dart';
import '../features/profile/profile_locator.dart';
import '../features/vendor/vendor_locator.dart';
import '../features/wallet/data/datasources/paystack_service.dart';
import '../features/wallet/wallet_locator.dart';

class SetUpLocators {
  static const SetUpLocators _instance = SetUpLocators._();
  const SetUpLocators._();
  factory SetUpLocators() => _instance;

  static final getIt = GetIt.instance;

  static void init() {
    _setUp();

    ///--------------- Authentication --------------------//
    setUpAuthenticationLocators();

    ///--------------- Vendor --------------------//
    setUpVendorLocator();

    ///--------------- Home --------------------//
    setUpHomeLocator();

    ///--------------- Wallet --------------------//
    setUpWalletLocator();

    /// --------------- Profile -----------------//
    setUpProfileLocators();
  }

  static void _setUp() {
    getIt.registerLazySingleton(() => FirebaseHelper());

    ///--------------- Push Notification --------------------//
    getIt.registerLazySingleton<PushNotificationHelper>(
      () => PushNotificationHelper(),
    );

    /// --------------- Paystack Service -----------------//
    getIt.registerLazySingleton(() => PaystackService());
  }
}
