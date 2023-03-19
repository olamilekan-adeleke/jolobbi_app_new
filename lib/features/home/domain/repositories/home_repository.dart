import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../entities/menu_item_entity.dart';
import '../entities/shop_details_entity.dart';

abstract class HomeRepository {
  Future<Either<Failures, List<ShopDetailsEntity>>> getNearByRestaurants();

  Future<Either<Failures, List<ShopDetailsEntity>>> getPopularRestaurants(
    String? lastDocId,
  );

  Future<Either<Failures, BaseEntity>> bookMarkRestaurant(String id);

  Future<Either<Failures, List<MenuItemEntity>>> getFoodMenuByQuery(
    String query,
    String? lastDocId,
  );

   Future<Either<Failures, List<ShopDetailsEntity>>> getRestaurants(
    String? lastDocId,
  );

   Future<Either<Failures, List<ShopDetailsEntity>>> searchRestaurantByQuery(
    String query,
    String? lastDocId,
  );
}
