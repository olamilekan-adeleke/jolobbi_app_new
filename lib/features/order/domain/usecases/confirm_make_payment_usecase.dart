import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';

import '../repositories/order_repository.dart';

class ConfirmMakePaymentUsecase
    implements UseCaseFuture<Failures, BaseEntity, String> {
  final OrderRepository orderRepository;

  const ConfirmMakePaymentUsecase({required this.orderRepository});

  @override
  FutureOr<Either<Failures, BaseEntity>> call(String params) async {
    return await orderRepository.confirmMadePayment(params);
  }
}
