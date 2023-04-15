import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../repositories/order_repository.dart';

class CancelOrderUsecase
    implements UseCaseFuture<Failures, BaseEntity, CancelOrderStatusParams> {
  final OrderRepository orderRepository;
  CancelOrderUsecase({required this.orderRepository});

  @override
  Future<Either<Failures, BaseEntity>> call(
    CancelOrderStatusParams params,
  ) async {
    return await orderRepository.cancelOrder(params.id, params.reason);
  }
}

class CancelOrderStatusParams {
  final String id;
  final String reason;

  CancelOrderStatusParams({required this.id, required this.reason});
}
