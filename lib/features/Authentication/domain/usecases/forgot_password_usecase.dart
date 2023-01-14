import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../domain.dart';

class ForgotPasswordUsecase implements UseCaseVoid<Failures, String> {
  final AuthenticationRepository _authenticationRepository;

  const ForgotPasswordUsecase(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  FutureOr<Either<Failures, void>> call(String params) async {
    return await _authenticationRepository.forgotPassword(params);
  }
}
