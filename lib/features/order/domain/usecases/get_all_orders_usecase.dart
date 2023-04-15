import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetAllOrderUsecase
    implements UseCaseFuture<Failures, List<OrderEntity>, String?> {
  final OrderRepository orderRepository;

  GetAllOrderUsecase({required this.orderRepository});

  @override
  Future<Either<Failures, List<OrderEntity>>> call(String? params) async {
    return await orderRepository.getOrders(params);
  }
}
