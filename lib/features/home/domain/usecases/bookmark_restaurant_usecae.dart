import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../repositories/home_repository.dart';

class BookmarkRestaurantUsecase
    implements UseCaseFuture<Failures, BaseEntity, BookmarkRestaurantParams> {
  final HomeRepository homeRepository;

  const BookmarkRestaurantUsecase({required this.homeRepository});

  @override
  Future<Either<Failures, BaseEntity>> call(
    BookmarkRestaurantParams params,
  ) async {
    return await homeRepository.bookMarkRestaurant(params.id);
  }
}

class BookmarkRestaurantParams {
  final String id;

  const BookmarkRestaurantParams({required this.id});
}
