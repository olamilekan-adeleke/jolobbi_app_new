// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String USERCOLLECTION = "users";

class FirebaseHelper {
  static FirebaseAuth get auth => FirebaseAuth.instance;

  static CollectionReference<Map<String, dynamic>> userCollectionRef() {
    return FirebaseFirestore.instance.collection(USERCOLLECTION);
  }
}
