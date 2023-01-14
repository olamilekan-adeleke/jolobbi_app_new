import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../presentation/presentation.dart';
import '../domain.dart';

abstract class AuthenticationRepository {
  Future<Either<Failures, AuthResultEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failures, AuthResultEntity>> register(
    SignUpFormModel signUpForm,
  );

  Future<Either<Failures, void>> logout();

  Future<Either<Failures, void>> forgotPassword(String email);
}
