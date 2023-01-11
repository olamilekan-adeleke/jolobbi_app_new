import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../domain.dart';

class LoginUsecase
    implements UseCaseFuture<Failures, AuthResultEntity, LoginDataParams> {
  final AuthenticationRepository _authenticationRepository;

  LoginUsecase({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  Future<Either<Failures, AuthResultEntity>> call(LoginDataParams login) async {
    return await _authenticationRepository.login(
      email: login.email,
      password: login.password,
    );
  }
}

class LoginDataParams {
  final String email;
  final String password;

  LoginDataParams({required this.email, required this.password});
}
