import 'package:get_it/get_it.dart';

import '../../app/locator.dart';
import 'presentation/cubit/fund_wallet_cubit.dart';

void setUpWalletLocator() {
  final GetIt getIt = SetUpLocators.getIt;

  // cubit
  getIt.registerLazySingleton(() => FundWalletCubit());
}
