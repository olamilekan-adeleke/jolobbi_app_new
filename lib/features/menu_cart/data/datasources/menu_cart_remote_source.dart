import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/firebase_helper/firebase_helper.dart';
import '../../presentation/formz/order_formz.dart';

abstract class MenuCartRemoteSource {
  Future<BaseModel> createOrder(OrderFormzModel order);

  Future<List<OrderModel>> getOrder(String? lastDoc);
}

class MenuCartRemoteSourceImpl implements MenuCartRemoteSource {
  final FirebaseHelper firebaseHelper;

  const MenuCartRemoteSourceImpl({required this.firebaseHelper});

  @override
  Future<BaseModel> createOrder(OrderFormzModel order) async {
    await firebaseHelper
        .orderCollectionRef()
        .doc(order.orderId)
        .set(order.toMap());

    return const BaseModel(
      message: 'Order created successfully',
      success: true,
    );
  }

  @override
  Future<List<OrderModel>> getOrder(String? lastDoc) async {
    Query<Map<String, dynamic>> query = firebaseHelper
        .orderCollectionRef()
        .limit(10)
        .orderBy('timestamp', descending: true);

    if (lastDoc != null) {
      query = query.startAfter([lastDoc]);
    }

    final QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();

    return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      return OrderModel.fromMap(doc.data());
    }).toList();
  }
}
