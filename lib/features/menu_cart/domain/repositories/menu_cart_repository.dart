import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../order/domain/entities/order_entity.dart';
import '../../presentation/formz/order_formz.dart';

abstract class MenuCartRepository {
  Future<Either<Failures, BaseEntity>> createOrder(OrderFormzModel order);

  Future<Either<Failures, List<OrderEntity>>> getOrder(String? lastDoc);
}
