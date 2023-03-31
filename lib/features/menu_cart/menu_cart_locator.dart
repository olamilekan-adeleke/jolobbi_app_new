import 'package:get_it/get_it.dart';

import '../../app/locator.dart';
import '../../cores/firebase_helper/firebase_helper.dart';
import 'data/datasources/menu_cart_remote_source.dart';
import 'data/repositories/menu_cart_repo_impl.dart';
import 'domain/repositories/menu_cart_repository.dart';
import 'domain/usecases/create_order_usecase.dart';
import 'domain/usecases/get_order_usecase.dart';
import 'presentation/bloc/create_order/create_order_bloc.dart';
import 'presentation/bloc/get_order/get_order_bloc.dart';
import 'presentation/cubit/cart_items_cubit.dart';
import 'presentation/cubit/create_order_cubit.dart';

void getUpMenuCartLocator() {
  final GetIt getIt = SetUpLocators.getIt;

  // remote data source
  getIt.registerLazySingleton<MenuCartRemoteSource>(
    () => MenuCartRemoteSourceImpl(firebaseHelper: getIt<FirebaseHelper>()),
  );

  // repository
  getIt.registerLazySingleton<MenuCartRepository>(
    () => MenuCartRepositoryImpl(
      menuCartRemoteSource: getIt<MenuCartRemoteSource>(),
    ),
  );

  // usecase
  getIt.registerLazySingleton<GetOrderUsecase>(
    () => GetOrderUsecase(menuCartRepository: getIt<MenuCartRepository>()),
  );

  getIt.registerLazySingleton<CreateOrderUsecase>(
    () => CreateOrderUsecase(menuCartRepository: getIt<MenuCartRepository>()),
  );

  // bloc
  getIt.registerLazySingleton<CreateOrderBloc>(
    () => CreateOrderBloc(createOrderUsecase: getIt<CreateOrderUsecase>()),
  );

  getIt.registerLazySingleton<GetOrderBloc>(
    () => GetOrderBloc(getOrderUsecase: getIt<GetOrderUsecase>()),
  );

  /// cubit
  getIt.registerLazySingleton<CartItemCubit>(() => CartItemCubit());
  getIt.registerLazySingleton<CreateOrderCubit>(() => CreateOrderCubit());
}
