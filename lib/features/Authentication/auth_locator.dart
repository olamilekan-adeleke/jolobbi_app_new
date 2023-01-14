import 'package:get_it/get_it.dart';
import 'package:jolobbi_app_new/app/locator.dart';
import 'presentation/bloc/login/login_bloc.dart';
import 'presentation/cubit/login_form_state_cubit.dart';

import 'data/datasources/authentication_remote_data_source.dart';
import 'data/repositories/authentication_repository_impl.dart';
import 'domain/domain.dart';
import 'domain/usecases/forgot_password_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/sign_up_usecase.dart';

void setUpAuthenticationLocators() {
  final GetIt getIt = SetUpLocators.getIt;

  // data
  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryIpml(
      authenticationRemoteDataSource: getIt<AuthenticationRemoteDataSource>(),
    ),
  );

  // UseCase
  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      authenticationRepository: getIt<AuthenticationRepository>(),
    ),
  );

  getIt.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(
      authenticationRepository: getIt<AuthenticationRepository>(),
    ),
  );

  getIt.registerLazySingleton<ForgotPasswordUsecase>(
    () => ForgotPasswordUsecase(
      authenticationRepository: getIt<AuthenticationRepository>(),
    ),
  );

  getIt.registerLazySingleton<LogOutUsecase>(
    () => LogOutUsecase(
      authenticationRepository: getIt<AuthenticationRepository>(),
    ),
  );

  /// Presentation
  // Cubit
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit());

  //Bloc
  getIt.registerLazySingleton<LoginBloc>(
    () => LoginBloc(loginUsecase: getIt<LoginUsecase>()),
  );
}
