import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../../presentation/presentation.dart';
import '../domain.dart';

class SignUpUsecase
    implements UseCaseFuture<Failures, AuthResultEntity, SignUpFormModel> {
  final AuthenticationRepository _authenticationRepository;

  const SignUpUsecase(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  FutureOr<Either<Failures, AuthResultEntity>> call(
    SignUpFormModel params,
  ) async {
    return await _authenticationRepository.register(params);
  }
}
