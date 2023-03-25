import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/params.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../repositories/wallet_repository.dart';

class WithdrawalUsecase
    implements UseCaseFuture<Failures, BaseEntity, NoParams> {
  final WalletRepository walletRepository;

  const WithdrawalUsecase({required this.walletRepository});

  @override
  FutureOr<Either<Failures, BaseEntity>> call(NoParams params) async {
    return await walletRepository.withdrawal();
  }
}
