import 'package:get_it/get_it.dart';

import '../../app/locator.dart';
import '../../cores/firebase_helper/firebase_helper.dart';
import 'data/datasources/vendor_remote_data_source.dart';
import 'data/repositories/vendor_repository_impl.dart';
import 'domain/repositories/vendor_repository.dart';
import 'domain/usecases/bookmark_menu_item_usecase.dart';
import 'domain/usecases/get_restaurant_drink_item_usecae.dart';
import 'domain/usecases/get_restaurant_food_item_usecase.dart';
import 'presentation/bloc/bookmark_menu_item/bookmark_menu_item_bloc.dart';
import 'presentation/bloc/get_restaurant_drink_item/get_restaurant_drink_item_bloc.dart';
import 'presentation/bloc/get_restaurant_food_item/get_restaurant_food_item_bloc.dart';

void setUpVendorLocator() {
  final GetIt getIt = SetUpLocators.getIt;

  // remote data source
  getIt.registerLazySingleton<VendorRemoteDataSource>(
    () => VendorRemoteDataSourceImpl(firebaseHelper: getIt<FirebaseHelper>()),
  );

  // repository
  getIt.registerLazySingleton<VendorRepository>(
    () => VendorRepositoryImpl(
      vendorRemoteDataSource: getIt<VendorRemoteDataSource>(),
    ),
  );

  // usecase
  getIt.registerLazySingleton(
    () => BookmarkMenuItemUsecase(vendorRepository: getIt<VendorRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetRestaurantDrinkItemUsecase(
      vendorRepository: getIt<VendorRepository>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetRestaurantFoodItemUsecase(
      vendorRepository: getIt<VendorRepository>(),
    ),
  );

  // bloc
  getIt.registerLazySingleton(
    () => BookmarkMenuItemBloc(
      bookmarkMenuItemUsecase: getIt<BookmarkMenuItemUsecase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetRestaurantFoodItemBloc(
      getRestaurantFoodItemUsecase: getIt<GetRestaurantFoodItemUsecase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetRestaurantDrinkItemBloc(
      getRestaurantDrinkItemUsecase: getIt<GetRestaurantDrinkItemUsecase>(),
    ),
  );
}
