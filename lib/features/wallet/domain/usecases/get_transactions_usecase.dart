import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../entities/transaction_entity.dart';
import '../repositories/wallet_repository.dart';

class GetTransactionUsecase
    implements UseCaseFuture<Failures, List<TransactionEntity>, String?> {
  final WalletRepository walletRepository;

  const GetTransactionUsecase({required this.walletRepository});

  @override
  FutureOr<Either<Failures, List<TransactionEntity>>> call(
    String? params,
  ) async {
    return await walletRepository.getTransaction(params);
  }
}
