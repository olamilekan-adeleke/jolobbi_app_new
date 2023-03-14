// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../exception/base_exception.dart';

String USERCOLLECTION = "users";
String SHOPCOLLECTION = "shops";
String MenuCOLLECTION = "menus_items";

class FirebaseHelper {
  /// -------- Utile ---------
  Timestamp get timestamp => Timestamp.now();

  /// -------- AUTHENTICATION ---------
  FirebaseAuth get auth => FirebaseAuth.instance;
  String get currentUserId {
    final String? userId = auth.currentUser?.uid;
    if (userId == null) throw const BaseFailures(message: 'User not found!');

    return userId;
  }

  /// -------- FIRESTORE ---------
  CollectionReference<Map<String, dynamic>> userCollectionRef() {
    return FirebaseFirestore.instance.collection(USERCOLLECTION);
  }

  CollectionReference<Map<String, dynamic>> shopCollectionRef() {
    return FirebaseFirestore.instance.collection(SHOPCOLLECTION);
  }

  DocumentReference<Map<String, dynamic>> shopStatsCollectionRef(String id) {
    return FirebaseFirestore.instance
        .collection(SHOPCOLLECTION)
        .doc(id)
        .collection('shop_sales')
        .doc('stats');
  }

  CollectionReference<Map<String, dynamic>> menuCollectionRef() {
    return FirebaseFirestore.instance.collection(MenuCOLLECTION);
  }

 

  /// -------- Storage ---------
  Reference storageRef() => FirebaseStorage.instance.ref();
}
