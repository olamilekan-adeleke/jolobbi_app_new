import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../../../home/domain/entities/menu_item_entity.dart';
import '../repositories/vendor_repository.dart';

class GetRestaurantFoodItemUsecase
    implements
        UseCaseFuture<Failures, List<MenuItemEntity>,
            GetRestaurantFoodItemParams> {
  final VendorRepository vendorRepository;

  const GetRestaurantFoodItemUsecase({required this.vendorRepository});

  @override
  FutureOr<Either<Failures, List<MenuItemEntity>>> call(
    GetRestaurantFoodItemParams params,
  ) async {
    return await vendorRepository.getRestaurantFoodItems(
      params.id,
      params.lastDocId,
    );
  }
}

class GetRestaurantFoodItemParams {
  final String id;
  final String? lastDocId;

  const GetRestaurantFoodItemParams({required this.id, this.lastDocId});
}
