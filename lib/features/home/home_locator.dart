import 'package:get_it/get_it.dart';
import 'presentation/bloc/search_restaurant/search_restaurant_bloc.dart';

import '../../app/locator.dart';
import '../../cores/firebase_helper/firebase_helper.dart';
import '../../cores/location_helper/location_helper.dart';
import 'data/datasources/home_remote_data_source.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/bookmark_restaurant_usecae.dart';
import 'domain/usecases/get_all_resturant_usecase.dart';
import 'domain/usecases/get_nearby_restaurants_usecae.dart';
import 'domain/usecases/get_popular_restaurant_usecase.dart';
import 'domain/usecases/search_menu_usecase.dart';
import 'domain/usecases/search_restaurant_usecase.dart';
import 'presentation/bloc/bookmark_restaurant/bookmark_restaurant_bloc.dart';
import 'presentation/bloc/get_all_restaurant/get_all_restaurant_bloc.dart';
import 'presentation/bloc/get_nearby_restaurant/get_nearby_restaurant_bloc.dart';
import 'presentation/bloc/get_popular_restaurant/get_popular_restaurant_bloc.dart';
import 'presentation/bloc/search_menu_item/search_menu_item_bloc.dart';

void setUpHomeLocator() {
  final GetIt getIt = SetUpLocators.getIt;

  // Remote Data Source
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      firebaseHelper: FirebaseHelper(),
      locationHelper: LocationHelper(),
    ),
  );

  // Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(homeRemoteDataSource: getIt()),
  );

  // usecase
  getIt.registerLazySingleton(
    () => GetNearbyRestaurantUsecase(homeRepository: getIt<HomeRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetPopularRestaurantUsecase(homeRepository: getIt<HomeRepository>()),
  );

  getIt.registerLazySingleton(
    () => BookmarkRestaurantUsecase(homeRepository: getIt<HomeRepository>()),
  );

  getIt.registerLazySingleton(
    () => SearchMenuItemUsecase(homeRepository: getIt<HomeRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetAllRestaurantsUsecase(homeRepository: getIt<HomeRepository>()),
  );

  getIt.registerLazySingleton(
    () => SearchRestaurantUsecase(homeRepository: getIt<HomeRepository>()),
  );

  // bloc
  getIt.registerFactory(
    () => BookmarkRestaurantBloc(
      bookmarkRestaurantUsecase: getIt<BookmarkRestaurantUsecase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetNearbyRestaurantBloc(
      getNearbyRestaurantUsecase: getIt<GetNearbyRestaurantUsecase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetPopularRestaurantBloc(
      getPopularRestaurantUsecase: getIt<GetPopularRestaurantUsecase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => SearchMenuItemBloc(
      searchMenuItemUsecase: getIt<SearchMenuItemUsecase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetAllRestaurantBloc(
      getAllRestaurantsUsecase: getIt<GetAllRestaurantsUsecase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => SearchRestaurantBloc(
      searchRestaurantUsecase: getIt<SearchRestaurantUsecase>(),
    ),
  );
}
