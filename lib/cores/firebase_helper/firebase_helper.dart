// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String USER_COLLECTION_REF = "users";

class FirebaseHelper {
  FirebaseAuth get auth => FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> userCollectionRef() {
    return FirebaseFirestore.instance.collection(USER_COLLECTION_REF);
  }
}
