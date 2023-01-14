import 'package:get_it/get_it.dart';
import 'package:jolobbi_app_new/features/Authentication/domain/usecases/sign_up_usecase.dart';

import '../features/Authentication/data/datasources/authentication_remote_data_source.dart';
import '../features/Authentication/data/repositories/authentication_repository_impl.dart';
import '../features/Authentication/domain/domain.dart';
import '../features/Authentication/domain/usecases/login_usecase.dart';
import '../features/Authentication/presentation/bloc/login/login_bloc.dart';
import '../features/Authentication/presentation/cubit/login_form_state_cubit.dart';

final getIt = GetIt.instance;

void setUpLocators() {
  ///--------------- Authentication --------------------//
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

  /// Presentation
  // Cubit
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit());

  //Bloc
  getIt.registerLazySingleton<LoginBloc>(
    () => LoginBloc(loginUsecase: getIt<LoginUsecase>()),
  );
}
