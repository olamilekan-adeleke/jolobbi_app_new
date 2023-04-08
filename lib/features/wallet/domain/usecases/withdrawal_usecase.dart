import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../repositories/wallet_repository.dart';

class WithdrawalUsecase
    implements UseCaseFuture<Failures, BaseEntity, WithdrawalParam> {
  final WalletRepository walletRepository;

  const WithdrawalUsecase({required this.walletRepository});

  @override
  FutureOr<Either<Failures, BaseEntity>> call(WithdrawalParam params) async {
    return await walletRepository.withdrawal(params.data);
  }
}

class WithdrawalParam {
  final Map<String, dynamic> data;

  const WithdrawalParam(this.data);
}
