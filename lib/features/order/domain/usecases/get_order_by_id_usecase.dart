import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrderByIdUsecase
    implements UseCaseFuture<Failures, OrderEntity, String> {
  final OrderRepository orderRepository;
  GetOrderByIdUsecase({required this.orderRepository});

  @override
  Future<Either<Failures, OrderEntity>> call(String params) async {
    return await orderRepository.getOrderById(params);
  }
}
