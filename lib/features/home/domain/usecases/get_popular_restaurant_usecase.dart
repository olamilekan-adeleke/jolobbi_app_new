import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../entities/shop_details_entity.dart';
import '../repositories/home_repository.dart';

class GetPopularRestaurantUsecase
    implements
        UseCaseFuture<Failures, List<ShopDetailsEntity>,
            GetPopularRestaurantParams> {
  final HomeRepository homeRepository;

  const GetPopularRestaurantUsecase({required this.homeRepository});

  @override
  Future<Either<Failures, List<ShopDetailsEntity>>> call(
    GetPopularRestaurantParams params,
  ) async {
    return await homeRepository.getPopularRestaurants(params.lastDocId);
  }
}

class GetPopularRestaurantParams {
  final String? lastDocId;

  const GetPopularRestaurantParams({required this.lastDocId});
}
