import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/firebase_helper/firebase_helper.dart';
import '../../domain/entities/order_entity.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders(String? lastDocTime);

  Future<OrderModel> getOrderById(String id);

  Stream<OrderEntity> getOrderStreamById(String id);

  Future<BaseModel> updateOrderStatus(String id, OrderStatus status);

  Future<BaseModel> deleteOrder(String id);

  Future<BaseModel> cancelOrder(String id, String reason);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseHelper firebaseHelper;

  const OrderRemoteDataSourceImpl({required this.firebaseHelper});

  @override
  Future<BaseModel> deleteOrder(String id) => throw UnimplementedError();

  @override
  Future<OrderModel> getOrderById(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firebaseHelper.orderCollectionRef().doc(id).get();

    return OrderModel.fromMap(documentSnapshot.data()!);
  }

  @override
  Future<List<OrderModel>> getOrders(String? lastDocTime) async {
    Query<Map<String, dynamic>> query =
        firebaseHelper.orderCollectionRef().where(
      'shopOwnersId',
      arrayContainsAny: [firebaseHelper.currentUserId],
    ).orderBy("timestamp", descending: true);

    if (lastDocTime != null) {
      query = firebaseHelper.orderCollectionRef().startAfter([lastDocTime]);
    }

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await query.limit(10).get();

    return querySnapshot.docs.map((e) => OrderModel.fromMap(e.data())).toList();
  }

  @override
  Future<BaseModel> updateOrderStatus(String id, OrderStatus status) async {
    await firebaseHelper.orderCollectionRef().doc(id).update({
      "status": status.getName,
      "statusHistory": FieldValue.arrayUnion(
        [
          {"status": status.getName, "time": DateTime.now()}
        ],
      ),
    });

    return const BaseModel(
      message: "Order status updated successfully",
      success: true,
    );
  }

  @override
  Stream<OrderEntity> getOrderStreamById(String id) {
    return firebaseHelper.orderCollectionRef().doc(id).snapshots().map(
      (event) {
        return OrderModel.fromMap(event.data()!);
      },
    );
  }

  @override
  Future<BaseModel> cancelOrder(String id, String reason) async {
    const OrderStatus status = OrderStatus.rejected;

    await firebaseHelper.orderCollectionRef().doc(id).update({
      "status": status.getName,
      "statusHistory": FieldValue.arrayUnion(
        [
          {
            "status": status.getName,
            "time": DateTime.now(),
            "reason": reason,
          }
        ],
      ),
    });

    return const BaseModel(
      message: "Order has be cancelled successfully",
      success: true,
    );
  }
}
