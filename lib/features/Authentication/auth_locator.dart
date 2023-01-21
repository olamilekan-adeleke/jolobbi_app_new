import 'package:get_it/get_it.dart';

import '../../app/locator.dart';
import '../../cores/firebase_helper/firebase_helper.dart';
import '../../cores/push_notification/push_nofication_helper.dart';
import 'data/datasources/authentication_remote_data_source.dart';
import 'data/repositories/authentication_repository_impl.dart';
import 'domain/domain.dart';
import 'domain/usecases/forgot_password_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/sign_up_usecase.dart';
import 'presentation/bloc/authentication_bloc.dart';
import 'presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'presentation/bloc/log_out/log_out_bloc.dart';
import 'presentation/bloc/login/login_bloc.dart';
import 'presentation/bloc/sign_up/sign_up_bloc.dart';
import 'presentation/cubit/login_form_state_cubit.dart';
import 'presentation/cubit/sign_up_form_state_cubit.dart';

void setUpAuthenticationLocators() {
  final GetIt getIt = SetUpLocators.getIt;

  // data
  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(
      firebaseHelper: FirebaseHelper(),
      pushNotificationHelper: getIt<PushNotificationHelper>(),
    ),
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
  getIt.registerLazySingleton<SignUpFormCubit>(() => SignUpFormCubit());

  //Bloc
  getIt.registerLazySingleton<LoginBloc>(
    () => LoginBloc(loginUsecase: getIt<LoginUsecase>()),
  );

  getIt.registerLazySingleton<SignUpBloc>(
    () => SignUpBloc(signUpUsecase: getIt<SignUpUsecase>()),
  );

  getIt.registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc());

  getIt.registerLazySingleton<ForgotPasswordBloc>(
    () => ForgotPasswordBloc(
        forgotPasswordUsecase: getIt<ForgotPasswordUsecase>()),
  );

  getIt.registerLazySingleton<LogOutBloc>(
    () => LogOutBloc(logOutUsecase: getIt<LogOutUsecase>()),
  );
}
