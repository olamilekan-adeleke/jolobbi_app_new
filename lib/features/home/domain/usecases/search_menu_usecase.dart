import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../entities/menu_item_entity.dart';
import '../repositories/home_repository.dart';

class SearchMenuItemUsecase
    implements
        UseCaseFuture<Failures, List<MenuItemEntity>, SearchMenuItemParams> {
  final HomeRepository homeRepository;

  const SearchMenuItemUsecase({required this.homeRepository});

  @override
  Future<Either<Failures, List<MenuItemEntity>>> call(
    SearchMenuItemParams params,
  ) async {
    return await homeRepository.getFoodMenuByQuery(
      params.query,
      params.lastDocId,
    );
  }
}

class SearchMenuItemParams {
  final String query;
  final String? lastDocId;

  const SearchMenuItemParams({required this.query, this.lastDocId});
}
