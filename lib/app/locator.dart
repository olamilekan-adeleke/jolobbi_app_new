import 'package:get_it/get_it.dart';
import '../features/Authentication/domain/usecases/login_usecase.dart';
import '../features/Authentication/presentation/bloc/login/login_bloc.dart';
import '../features/Authentication/presentation/cubit/login_form_state_cubit.dart';

import '../features/Authentication/data/datasources/authentication_remote_data_source.dart';
import '../features/Authentication/data/repositories/authentication_repository_impl.dart';
import '../features/Authentication/domain/domain.dart';

final getIt = GetIt.instance;

void setUpLocator() {
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

  // Domain
  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
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
