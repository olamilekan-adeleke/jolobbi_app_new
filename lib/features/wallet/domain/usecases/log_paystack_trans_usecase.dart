import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../repositories/wallet_repository.dart';

class LogPaystackTransUsecase
    implements UseCaseFuture<Failures, BaseEntity, Map<String, dynamic>> {
  final WalletRepository walletRepository;

  const LogPaystackTransUsecase({required this.walletRepository});

  @override
  FutureOr<Either<Failures, BaseEntity>> call(
    Map<String, dynamic> params,
  ) async {
    return await walletRepository.logPaystackTrans(params);
  }
}
