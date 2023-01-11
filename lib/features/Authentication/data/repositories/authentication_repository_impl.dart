import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../cores/exception/base_exception.dart';
import '../../../../cores/exception/firebase_auth_exception.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/failures/error_text.dart';
import '../../../../cores/utils/utils.dart';
import '../../domain/domain.dart';
import '../../presentation/forms_model/sign_up_forms_model.dart';
import '../datasources/authentication_remote_data_source.dart';
import '../models/auth_result_model.dart';

class AuthenticationRepositoryIpml extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;

  AuthenticationRepositoryIpml({
    required AuthenticationRemoteDataSource authenticationRemoteDataSource,
  }) : _authenticationRemoteDataSource = authenticationRemoteDataSource;

  @override
  Future<Either<Failures, AuthResultEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResultModel result =
          await _authenticationRemoteDataSource.login(email, password);

      return Either.right(result);
    } on FirebaseAuthException catch (e) {
      return Either.left(AuthFirebaseException(e.code));
    } on SocketException {
      return const Left(BaseException(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseException) {
        return Either.left(BaseException(message: e.message));
      }

      return Either.left(BaseException(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, AuthResultEntity>> register(
      SignUpFormModel signUpForm) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
