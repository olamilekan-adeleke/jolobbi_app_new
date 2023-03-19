import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../../../home/domain/entities/menu_item_entity.dart';
import '../repositories/vendor_repository.dart';

class GetRestaurantDrinkItemUsecase
    implements
        UseCaseFuture<Failures, List<MenuItemEntity>,
            GetRestaurantDrinkItemParams> {
  final VendorRepository vendorRepository;

  const GetRestaurantDrinkItemUsecase({required this.vendorRepository});

  @override
  FutureOr<Either<Failures, List<MenuItemEntity>>> call(
    GetRestaurantDrinkItemParams params,
  ) async {
    return await vendorRepository.getRestaurantDrinkItems(
      params.id,
      params.lastDocId,
    );
  }
}

class GetRestaurantDrinkItemParams {
  final String id;
  final String? lastDocId;

  const GetRestaurantDrinkItemParams({required this.id, this.lastDocId});
}
