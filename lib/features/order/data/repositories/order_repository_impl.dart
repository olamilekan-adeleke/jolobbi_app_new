import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/exception/base_exception.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/failures/error_text.dart';
import '../../../../cores/utils/logger.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;
  const OrderRepositoryImpl({required this.orderRemoteDataSource});

  @override
  Future<Either<Failures, OrderEntity>> getOrderById(String id) async {
    try {
      OrderModel result = await orderRemoteDataSource.getOrderById(id);

      return Either.right(result);
    } on SocketFailures {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<OrderEntity>>> getOrders(
    String? lastDocTime,
  ) async {
    try {
      final List<OrderModel> result =
          await orderRemoteDataSource.getOrders(lastDocTime);

      return Either.right(result);
    } on SocketFailures {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, BaseEntity>> updateOrderStatus(
    String id,
    OrderStatus status,
  ) async {
    try {
      final BaseEntity result =
          await orderRemoteDataSource.updateOrderStatus(id, status);

      return Either.right(result);
    } on SocketFailures {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, BaseEntity>> deleteOrder(String id) async {
    try {
      final BaseModel result = await orderRemoteDataSource.deleteOrder(id);

      return Either.right(result);
    } on SocketFailures {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, BaseEntity>> cancelOrder(
    String id,
    String reason,
  ) async {
    try {
      final BaseModel result = await orderRemoteDataSource.cancelOrder(
        id,
        reason,
      );

      return Either.right(result);
    } on SocketFailures {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }
}
