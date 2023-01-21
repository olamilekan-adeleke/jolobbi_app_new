import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../cores/exception/base_exception.dart';
import '../../../../cores/firebase_helper/firebase_helper.dart';
import '../../../../cores/push_notification/push_nofication_helper.dart';
import '../../presentation/presentation.dart';
import '../models/auth_result_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AuthResultModel> login(String email, String password);

  Future<AuthResultModel> signUp(SignUpFormModel signUpForm);

  Future<void> forgotPassword(String email);

  Future<void> logOut();
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final PushNotificationHelper _pushNotificationHelper;
  final FirebaseHelper _firebaseHelper;

  AuthenticationRemoteDataSourceImpl({
    required PushNotificationHelper pushNotificationHelper,
    required FirebaseHelper firebaseHelper,
  })  : _pushNotificationHelper = pushNotificationHelper,
        _firebaseHelper = firebaseHelper;

  @override
  Future<void> logOut() async {
    return await _firebaseHelper.auth.signOut();
  }

  @override
  Future<AuthResultModel> login(String email, String password) async {
    final UserCredential userCredential = await _firebaseHelper.auth
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user == null) {
      throw const BaseException(
        message: "Unable to login user with this credential",
      );
    }

    await _updateFcmToken(userCredential.user!.uid);

    return const AuthResultModel(success: true, message: 'Login success');
  }

  @override
  Future<AuthResultModel> signUp(SignUpFormModel signUpForm) async {
    await _checkIfUsernameAlreadyExist(signUpForm.username.value);

    final UserCredential userCredential =
        await _firebaseHelper.auth.createUserWithEmailAndPassword(
      email: signUpForm.email.value,
      password: signUpForm.password.value,
    );

    if (userCredential.user == null) {
      throw const BaseException(
        message: "Unable to create account with this credential",
      );
    }

    final String? fcmToken = await _pushNotificationHelper.getFCMToken();

    // Save User Data to Firestore
    final User user = userCredential.user!;
    await _firebaseHelper
        .userCollectionRef()
        .doc(user.uid)
        .set(signUpForm.toMap(userId: user.uid, fcmToken: fcmToken));

    return const AuthResultModel(
      success: true,
      message: 'Account Successfully Created!',
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    return await _firebaseHelper.auth.sendPasswordResetEmail(email: email);
  }

  Future<void> _updateFcmToken(String userId) async {
    final String? fcmToken = await _pushNotificationHelper.getFCMToken();

    _firebaseHelper
        .userCollectionRef()
        .doc(userId)
        .update({"fcmToken": fcmToken ?? ""});
  }

  Future<void> _checkIfUsernameAlreadyExist(String username) async {
    final AggregateQuerySnapshot aggregateQuerySnapshot = await _firebaseHelper
        .userCollectionRef()
        .where("username", isEqualTo: username)
        .count()
        .get(source: AggregateSource.server);

    final int count = aggregateQuerySnapshot.count;

    if (count > 0) {
      throw const BaseException(message: "Username already exist!");
    }
  }
}
