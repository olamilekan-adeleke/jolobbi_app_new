import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../../data/models/order_model.dart';
import '../repositories/order_repository.dart';

class UpdateOrderUsecase
    implements UseCaseFuture<Failures, BaseEntity, UpdateOrderStatusParams> {
  final OrderRepository orderRepository;
  UpdateOrderUsecase({required this.orderRepository});

  @override
  Future<Either<Failures, BaseEntity>> call(
    UpdateOrderStatusParams params,
  ) async {
    return await orderRepository.updateOrderStatus(params.id, params.status);
  }
}

class UpdateOrderStatusParams {
  final String id;
  final OrderStatus status;

  UpdateOrderStatusParams({required this.id, required this.status});
}
