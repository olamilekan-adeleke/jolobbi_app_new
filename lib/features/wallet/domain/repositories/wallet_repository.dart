import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../entities/transaction_entity.dart';
import '../entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<Either<Failures, WalletEntity>> getWallet();

  Future<Either<Failures, List<TransactionEntity>>> getTransaction(
    String? lastDoc,
  );

  Future<Either<Failures, BaseEntity>> logFlutterWaveTrans(
    Map<String, dynamic> data,
  );

  Future<Either<Failures, BaseEntity>> logPaystackTrans(
    Map<String, dynamic> data,
  );

  Future<Either<Failures, BaseEntity>> withdrawal();
}
