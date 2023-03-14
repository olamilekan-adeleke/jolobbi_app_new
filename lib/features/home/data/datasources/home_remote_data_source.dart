import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:location/location.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/firebase_helper/firebase_helper.dart';
import '../../../../cores/location_helper/location_helper.dart';
import '../models/menu_item_model.dart';
import '../models/shop_details_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ShopDetailsModel>> getNearByRestaurants();

  Future<List<ShopDetailsModel>> getPopularRestaurants(String? lastDocId);

  Future<BaseModel> bookMarkRestaurant(String id);

  Future<List<MenuItemModel>> getFoodMenuByQuery(
    String query,
    String? lastDocId,
  );
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseHelper firebaseHelper;
  final LocationHelper locationHelper;

  const HomeRemoteDataSourceImpl({
    required this.firebaseHelper,
    required this.locationHelper,
  });

  @override
  Future<List<ShopDetailsModel>> getNearByRestaurants() async {
    final LocationData? location =
        await locationHelper.getUserCurrentLocation();

    if (location == null) {
      throw Exception(
        'Unable to get your current location, please try again later',
      );
    }

    final GeoFlutterFire geo = GeoFlutterFire();
    final double latitude = location.latitude ?? 0;
    final double longitude = location.longitude ?? 0;

    final GeoFirePoint center =
        geo.point(latitude: latitude, longitude: longitude);
    final Query<Map<String, dynamic>> collectionReference = firebaseHelper
        .shopCollectionRef()
        .where('type', isEqualTo: 'FOOD')
        .limit(10);

    String field = 'position';

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: 50, field: field);

    return stream.first.then(
      (value) {
        return value.map(
          (e) {
            final Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            return ShopDetailsModel.fromMap(data);
          },
        ).toList();
      },
    );
  }

  @override
  Future<List<ShopDetailsModel>> getPopularRestaurants(
    String? lastDocId,
  ) async {
    Query<Map<String, dynamic>> collectionReference =
        firebaseHelper.shopCollectionRef().orderBy("numberOfLikes");

    if (lastDocId != null) {
      collectionReference = collectionReference.startAfter([lastDocId]);
    }

    QuerySnapshot<Map<String, dynamic>> result =
        await collectionReference.limit(10).get();
    return result.docs.map((e) => ShopDetailsModel.fromMap(e.data())).toList();
  }

  @override
  Future<List<MenuItemModel>> getFoodMenuByQuery(
    String query,
    String? lastDocId,
  ) async {
    var collectionReference = firebaseHelper
        .menuCollectionRef()
        .where('type', isEqualTo: "FOOD")
        .where('searchKey', arrayContains: query);

    if (lastDocId != null) {
      collectionReference = collectionReference.startAfter([lastDocId]);
    }

    QuerySnapshot<Map<String, dynamic>> result =
        await collectionReference.limit(10).get();
    return result.docs.map((e) => MenuItemModel.fromMap(e.data())).toList();
  }

  @override
  Future<BaseModel> bookMarkRestaurant(String id) async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        firebaseHelper.userCollectionRef();

    await collectionReference.doc(firebaseHelper.currentUserId).update({
      'bookmarks': FieldValue.arrayUnion([id])
    });

    return const BaseModel(
      message: 'Restaurant bookmarked successfully',
      success: true,
    );
  }
}
