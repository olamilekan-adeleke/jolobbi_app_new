import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/firebase_helper/firebase_helper.dart';
import '../models/user_details_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserDetailsModel> getProfile();

  Future<BaseModel> updateProfile(Map<String, dynamic> data);

  Future<BaseModel> updatePassword(String email);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseHelper _firebaseHelper;

  ProfileRemoteDataSourceImpl({required FirebaseHelper firebaseHelper})
      : _firebaseHelper = firebaseHelper;

  @override
  Future<UserDetailsModel> getProfile() async {
    final String userId = _firebaseHelper.currentUserId;

    final DocumentSnapshot<Map<String, dynamic>> result =
        await _firebaseHelper.userCollectionRef().doc(userId).get();

    return UserDetailsModel.fromMap(result.data()!);
  }

  @override
  Future<BaseModel> updatePassword(String email) async {
    await _firebaseHelper.auth.sendPasswordResetEmail(email: email);

    return const BaseModel(
      success: true,
      message: "Password reset email sent, Please check your email for"
          " further instruction",
    );
  }

  @override
  Future<BaseModel> updateProfile(Map<String, dynamic> data) async {
    final String userId = _firebaseHelper.currentUserId;

    await _firebaseHelper.userCollectionRef().doc(userId).update(data);

    return const BaseModel(
      success: true,
      message: "Profile updated successfully!",
    );
  }
}
