import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../entities/shop_details_entity.dart';
import '../repositories/home_repository.dart';

class GetAllRestaurantsUsecase
    implements
        UseCaseFuture<Failures, List<ShopDetailsEntity>, GetRestaurantParams> {
  final HomeRepository homeRepository;

  const GetAllRestaurantsUsecase({required this.homeRepository});

  @override
  Future<Either<Failures, List<ShopDetailsEntity>>> call(
    GetRestaurantParams params,
  ) async {
    return await homeRepository.getRestaurants(params.lastDocId);
  }
}

class GetRestaurantParams {
  final String? lastDocId;

  const GetRestaurantParams(this.lastDocId);
}
