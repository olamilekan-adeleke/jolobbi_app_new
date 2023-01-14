import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/params.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../domain.dart';

class LogOutUsecase implements UseCaseVoid<Failures, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  const LogOutUsecase(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  FutureOr<Either<Failures, void>> call(NoParams params) async {
    return await _authenticationRepository.logout();
  }
}
