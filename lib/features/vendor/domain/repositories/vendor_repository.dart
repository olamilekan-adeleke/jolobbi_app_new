import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../home/domain/entities/menu_item_entity.dart';

abstract class VendorRepository {
  Future<Either<Failures, BaseEntity>> bookmarkMenuItem(String id);

  Future<Either<Failures, List<MenuItemEntity>>> getRestaurantFoodItems(
    String id,
    String? lastDocId,
  );
  
  Future<Either<Failures, List<MenuItemEntity>>> getRestaurantDrinkItems(
    String id,
    String? lastDocId,
  );
}
