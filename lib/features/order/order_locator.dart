import 'package:get_it/get_it.dart';
import 'presentation/bloc/confirm_make_payment/confirm_make_payment_bloc.dart';

import '../../app/locator.dart';
import '../../cores/firebase_helper/firebase_helper.dart';
import 'data/datasources/order_remote_data_source.dart';
import 'data/repositories/order_repository_impl.dart';
import 'domain/repositories/order_repository.dart';
import 'domain/usecases/cancel_order_usecase.dart';
import 'domain/usecases/confirm_make_payment_usecase.dart';
import 'domain/usecases/get_all_orders_usecase.dart';
import 'domain/usecases/get_order_by_id_usecase.dart';
import 'domain/usecases/update_order_usecase.dart';
import 'presentation/bloc/cancel_order/cancel_order_bloc.dart';
import 'presentation/bloc/get_all_orders/get_all_orders_bloc.dart';
import 'presentation/bloc/get_order_by_id/get_order_by_id_bloc.dart';
import 'presentation/bloc/update_order/update_order_bloc.dart';

void setUpOrderLocator() {
  final GetIt getIt = SetUpLocators.getIt;

  // remote data source
  getIt.registerFactory<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(firebaseHelper: getIt<FirebaseHelper>()),
  );

  // repository

  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
        orderRemoteDataSource: getIt<OrderRemoteDataSource>()),
  );

  // usecase
  getIt.registerLazySingleton(
    () => GetAllOrderUsecase(orderRepository: getIt<OrderRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetOrderByIdUsecase(orderRepository: getIt<OrderRepository>()),
  );

  getIt.registerLazySingleton(
    () => UpdateOrderUsecase(orderRepository: getIt<OrderRepository>()),
  );

  getIt.registerLazySingleton(
    () => CancelOrderUsecase(orderRepository: getIt<OrderRepository>()),
  );

  getIt.registerLazySingleton(
    () => ConfirmMakePaymentUsecase(orderRepository: getIt<OrderRepository>()),
  );

  // bloc
  getIt.registerLazySingleton(
    () => GetAllOrdersBloc(getAllOrderUsecase: getIt<GetAllOrderUsecase>()),
  );

  getIt.registerLazySingleton(
    () => GetOrderByIdBloc(getOrderByIdUsecase: getIt<GetOrderByIdUsecase>()),
  );

  getIt.registerLazySingleton(
    () => UpdateOrderBloc(updateOrderUsecase: getIt<UpdateOrderUsecase>()),
  );

  getIt.registerLazySingleton(
    () => CancelOrderBloc(cancelOrderUsecase: getIt<CancelOrderUsecase>()),
  );

  getIt.registerLazySingleton(
    () => ConfirmMakePaymentBloc(
      confirmMakePaymentUsecase: getIt<ConfirmMakePaymentUsecase>(),
    ),
  );
}
