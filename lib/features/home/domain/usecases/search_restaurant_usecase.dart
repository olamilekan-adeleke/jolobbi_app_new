import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../entities/shop_details_entity.dart';
import '../repositories/home_repository.dart';

class SearchRestaurantUsecase
    implements
        UseCaseFuture<Failures, List<ShopDetailsEntity>, SearchRestaurantParams> {
  final HomeRepository homeRepository;

  const SearchRestaurantUsecase({required this.homeRepository});

  @override
  Future<Either<Failures, List<ShopDetailsEntity>>> call(
    SearchRestaurantParams params,
  ) async {
    return await homeRepository.searchRestaurantByQuery(
      params.query,
      params.lastDocId,
    );
  }
}

class SearchRestaurantParams {
  final String query;
  final String? lastDocId;

  const SearchRestaurantParams({required this.query, this.lastDocId});
}
