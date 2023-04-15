import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../data/models/order_model.dart';
import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failures, List<OrderEntity>>> getOrders(String? lastDocTime);

  Future<Either<Failures, OrderEntity>> getOrderById(String id);

  Future<Either<Failures, BaseEntity>> updateOrderStatus(
    String id,
    OrderStatus status,
  );

  Future<Either<Failures, BaseEntity>> deleteOrder(String id);

  Future<Either<Failures, BaseEntity>> cancelOrder(String id, String reason);
}
