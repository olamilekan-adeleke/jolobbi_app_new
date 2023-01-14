import 'package:firebase_auth/firebase_auth.dart';

import '../../../../cores/exception/base_exception.dart';
import '../../../../cores/firebase_helper/firebase_helper.dart';
import '../../presentation/presentation.dart';
import '../models/auth_result_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AuthResultModel> login(String email, String password);

  Future<AuthResultModel> signUp(SignUpFormModel signUpForm);

  Future<void> logOut();
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  @override
  Future<void> logOut() async {
    return await FirebaseHelper.auth.signOut();
  }

  @override
  Future<AuthResultModel> login(String email, String password) async {
    final UserCredential userCredential = await FirebaseHelper.auth
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user == null) {
      throw const BaseException(
        message: "Unable to login user with this credential",
      );
    }

    return const AuthResultModel(success: true, message: 'Login success');
  }

  @override
  Future<AuthResultModel> signUp(SignUpFormModel signUpForm) async {
    final UserCredential userCredential =
        await FirebaseHelper.auth.createUserWithEmailAndPassword(
      email: signUpForm.email,
      password: signUpForm.password,
    );

    if (userCredential.user == null) {
      throw const BaseException(
        message: "Unable to create account with this credential",
      );
    }

    // Save User Data to Firestore
    final User user = userCredential.user!;
    await FirebaseHelper.userCollectionRef()
        .doc(user.uid)
        .set(signUpForm.toMap(user.uid));

    return const AuthResultModel(
      success: true,
      message: 'Account Successfully Created!',
    );
  }
}
