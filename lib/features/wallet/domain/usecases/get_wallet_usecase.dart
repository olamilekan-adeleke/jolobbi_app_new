import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/params.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../entities/wallet_entity.dart';
import '../repositories/wallet_repository.dart';

class GetWalletUsecase
    implements UseCaseFuture<Failures, WalletEntity, NoParams> {
  final WalletRepository walletRepository;

  const GetWalletUsecase({required this.walletRepository});

  @override
  FutureOr<Either<Failures, WalletEntity>> call(NoParams params) async {
    return await walletRepository.getWallet();
  }
}
