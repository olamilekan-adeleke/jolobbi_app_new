import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jolobbi_app_new/features/menu_cart/data/models/order_model.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/exception/base_exception.dart';
import '../../../../cores/exception/firebase_auth_exception.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/failures/error_text.dart';
import '../../../../cores/utils/logger.dart';
import '../../../order/domain/entities/order_entity.dart';
import '../../domain/repositories/menu_cart_repository.dart';
import '../../presentation/formz/order_formz.dart';
import '../datasources/menu_cart_remote_source.dart';

class MenuCartRepositoryImpl implements MenuCartRepository {
  final MenuCartRemoteSource menuCartRemoteSource;

  const MenuCartRepositoryImpl({required this.menuCartRemoteSource});

  @override
  Future<Either<Failures, BaseEntity>> createOrder(
    OrderFormzModel order,
  ) async {
    try {
      final BaseModel result = await menuCartRemoteSource.createOrder(order);

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFirebaseException(e.code));
    } on SocketException {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Left(BaseFailures(message: e.message));
      }

      return Left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<OrderEntity>>> getOrder(String? lastDoc) async {
    try {
      final List<OrderModel> result =
          await menuCartRemoteSource.getOrder(lastDoc);

      return Right(result as List<OrderEntity>);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFirebaseException(e.code));
    } on SocketException {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Left(BaseFailures(message: e.message));
      }

      return Left(BaseFailures(message: e.toString()));
    }
  }
}
