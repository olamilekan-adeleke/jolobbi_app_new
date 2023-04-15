import 'package:get_it/get_it.dart';

import '../../app/locator.dart';
import '../../cores/firebase_helper/firebase_helper.dart';
import 'data/datasources/wallet_remote_data_source.dart';
import 'data/repositories/wallet_repository_impl.dart';
import 'domain/repositories/wallet_repository.dart';
import 'domain/usecases/get_transactions_usecase.dart';
import 'domain/usecases/get_wallet_usecase.dart';
import 'domain/usecases/log_flutter_wave_trans_usecase.dart';
import 'domain/usecases/log_paystack_trans_usecase.dart';
import 'domain/usecases/withdrawal_usecase.dart';
import 'presentation/bloc/get_transaction/get_transaction_bloc.dart';
import 'presentation/bloc/get_wallet/get_wallet_bloc.dart';
import 'presentation/bloc/log_trans/log_trans_bloc.dart';
import 'presentation/bloc/withdrawal/withdrawal_bloc.dart';
import 'presentation/cubit/fund_wallet_cubit.dart';
import 'presentation/cubit/withdrawal_cubit.dart';

void setUpWalletLocator() {
  final GetIt getIt = SetUpLocators.getIt;

  // remote data source
  getIt.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(
      firebaseHelper: getIt<FirebaseHelper>(),
    ),
  );

  // repository
  getIt.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(
      walletRemoteDataSource: getIt<WalletRemoteDataSource>(),
    ),
  );

  // usecase
  getIt.registerLazySingleton(
    () => GetWalletUsecase(walletRepository: getIt<WalletRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetTransactionUsecase(walletRepository: getIt<WalletRepository>()),
  );

  getIt.registerLazySingleton(
    () => LogFlutterWaveTransUsecase(
      walletRepository: getIt<WalletRepository>(),
    ),
  );

  getIt.registerLazySingleton(
    () => LogPaystackTransUsecase(walletRepository: getIt<WalletRepository>()),
  );

  getIt.registerLazySingleton(
    () => WithdrawalUsecase(walletRepository: getIt<WalletRepository>()),
  );

  // bloc
  getIt.registerLazySingleton(
    () => GetWalletBloc(getWalletUsecase: getIt<GetWalletUsecase>()),
  );

  getIt.registerLazySingleton(
    () => GetTransactionBloc(
      getTransactionUsecase: getIt<GetTransactionUsecase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => LogTransBloc(
      logFlutterWaveTransUsecase: getIt<LogFlutterWaveTransUsecase>(),
      logPaystackTransUsecase: getIt<LogPaystackTransUsecase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => WithdrawalBloc(withdrawalUsecase: getIt<WithdrawalUsecase>()),
  );

  // cubit
  getIt.registerLazySingleton(() => FundWalletCubit());
  getIt.registerLazySingleton(() => WithdrawalCubit());
}
