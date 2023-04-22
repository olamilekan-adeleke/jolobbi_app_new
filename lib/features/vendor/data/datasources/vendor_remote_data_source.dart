import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../cores/firebase_helper/firebase_helper.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../home/data/models/menu_item_model.dart';
import '../../../home/domain/entities/menu_item_entity.dart';

abstract class VendorRemoteDataSource {
  Future<List<MenuItemModel>> getRestaurantFoodItems(
    String id,
    String? lastDocId,
  );

  Future<List<MenuItemModel>> getRestaurantDrinkItems(
    String id,
    String? lastDocId,
  );

  Future<BaseModel> bookmarkMenuItem(String id);

  Stream<MenuItemEntity> streamRestaurantFoodItems(String id);
}

class VendorRemoteDataSourceImpl implements VendorRemoteDataSource {
  final FirebaseHelper firebaseHelper;

  const VendorRemoteDataSourceImpl({required this.firebaseHelper});

  @override
  Future<BaseModel> bookmarkMenuItem(String id) async {
    await firebaseHelper
        .userCollectionRef()
        .doc(firebaseHelper.currentUserId)
        .collection('bookmark')
        .doc('menu')
        .update(
      {
        'bookmarks': FieldValue.arrayUnion([id])
      },
    );

    return const BaseModel(
      message: 'Bookmark added successfully',
      success: true,
    );
  }

  @override
  Future<List<MenuItemModel>> getRestaurantDrinkItems(
    String id,
    String? lastDocId,
  ) async {
    Query<Map<String, dynamic>> query = firebaseHelper
        .menuCollectionRef()
        .where("shopId", isEqualTo: id)
        .where("subType", isEqualTo: "DRINK")
        .orderBy('name');

    if (lastDocId != null) query = query.startAfter([lastDocId]);
    QuerySnapshot<Map<String, dynamic>> snapshot = await query.limit(10).get();

    return snapshot.docs.map((e) => MenuItemModel.fromMap(e.data())).toList();
  }

  @override
  Future<List<MenuItemModel>> getRestaurantFoodItems(
    String id,
    String? lastDocId,
  ) async {
    Query<Map<String, dynamic>> query = firebaseHelper
        .menuCollectionRef()
        .where("shopId", isEqualTo: id)
        .where("subType", isEqualTo: "FOOD")
        .orderBy('name');

    if (lastDocId != null) query = query.startAfter([lastDocId]);
    QuerySnapshot<Map<String, dynamic>> snapshot = await query.limit(10).get();

    return snapshot.docs.map((e) => MenuItemModel.fromMap(e.data())).toList();
  }

  @override
  Stream<MenuItemEntity> streamRestaurantFoodItems(String id) {
    return firebaseHelper.menuCollectionRef().doc(id).snapshots().map((event) {
      return MenuItemModel.fromMap(event.data()!);
    });
  }
}
