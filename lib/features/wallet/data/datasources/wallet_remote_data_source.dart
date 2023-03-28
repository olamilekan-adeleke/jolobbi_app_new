import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/firebase_helper/firebase_helper.dart';
import '../models/transaction_model.dart';
import '../models/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Future<WalletModel> getWallet();

  Future<List<TransactionModel>> getTransaction(String? lastDoc);

  Future<BaseEntity> logFlutterWaveTrans(Map<String, dynamic> data);

  Future<BaseEntity> logPaystackTrans(Map<String, dynamic> data);

  Future<BaseEntity> withdrawal();
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final FirebaseHelper firebaseHelper;

  const WalletRemoteDataSourceImpl({required this.firebaseHelper});

  @override
  Future<List<TransactionModel>> getTransaction(String? lastDoc) async {
    final QuerySnapshot<Map<String, dynamic>> query = await firebaseHelper
        .transactionCollectionRef()
        .orderBy('date', descending: true)
        // .startAfter([lastDoc])
        .limit(10)
        .get();

    final List<TransactionModel> transactions = query.docs.map(
      (DocumentSnapshot<Map<String, dynamic>> doc) {
        return TransactionModel.fromMap(doc.data()!);
      },
    ).toList();

    return transactions;
  }

  @override
  Future<WalletModel> getWallet() async {
    final DocumentSnapshot<Map<String, dynamic>> doc = await firebaseHelper
        .walletCollectionRef()
        .doc(firebaseHelper.currentUserId)
        .get();

    return WalletModel.fromMap(doc.data()!);
  }

  @override
  Future<BaseEntity> logFlutterWaveTrans(Map<String, dynamic> data) async {
    await firebaseHelper.flutterWaveTransCollectionRef().add(data);

    return const BaseEntity(
      message: 'Transaction logged successfully',
      success: true,
    );
  }

  @override
  Future<BaseEntity> logPaystackTrans(Map<String, dynamic> data) async {
    await firebaseHelper.paystackTransCollectionRef().add(data);

    return const BaseEntity(
      message: 'Transaction logged successfully',
      success: true,
    );
  }

  @override
  Future<BaseEntity> withdrawal() {
    throw UnimplementedError();
  }
}
