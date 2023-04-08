import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../../../order/domain/entities/order_entity.dart';
import '../repositories/menu_cart_repository.dart';

class GetOrderUsecase
    implements UseCaseFuture<Failures, List<OrderEntity>, String?> {
  final MenuCartRepository menuCartRepository;

  const GetOrderUsecase({required this.menuCartRepository});

  @override
  Future<Either<Failures, List<OrderEntity>>> call(String? lastDoc) async {
    return await menuCartRepository.getOrder(lastDoc);
  }
}
