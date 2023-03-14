import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/params.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../entities/shop_details_entity.dart';
import '../repositories/home_repository.dart';

class GetNearbyRestaurantUsecase
    implements UseCaseFuture<Failures, List<ShopDetailsEntity>, NoParams> {
  final HomeRepository homeRepository;

  const GetNearbyRestaurantUsecase({required this.homeRepository});

  @override
  Future<Either<Failures, List<ShopDetailsEntity>>> call(
    NoParams params,
  ) async {
    return await homeRepository.getNearByRestaurants();
  }
}
