import 'package:get_it/get_it.dart';

import '../../app/locator.dart';
import '../../cores/firebase_helper/firebase_helper.dart';
import 'data/datasources/profile_remote_data_source.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/add_address_usecase.dart';
import 'domain/usecases/get_user_address_usecase.dart';
import 'domain/usecases/get_user_profile_usecase.dart';
import 'domain/usecases/update_password_usecase.dart';
import 'domain/usecases/update_user_profile_usecase.dart';
import 'presentation/bloc/add_address/add_address_bloc.dart';
import 'presentation/bloc/get_address_bloc/get_address_bloc_bloc.dart';
import 'presentation/bloc/get_profile/get_profile_bloc_bloc.dart';
import 'presentation/bloc/update_password_bloc/update_password_bloc.dart';
import 'presentation/bloc/update_user_profile/update_user_profile_bloc.dart';
import 'presentation/cubit/add_address_cubit.dart';

void setUpProfileLocators() {
  final GetIt getIt = SetUpLocators.getIt;

  /// -------- Data Source ---------
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(firebaseHelper: FirebaseHelper()),
  );

  /// -------- Domain ---------
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileRemoteDataSource: getIt<ProfileRemoteDataSource>(),
    ),
  );

  /// -------- Use Cases ---------
  getIt.registerLazySingleton<GetUserProfileUsecase>(
    () => GetUserProfileUsecase(profileRepository: getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton<UpdateUserProfileUsecase>(
    () => UpdateUserProfileUsecase(
      profileRepository: getIt<ProfileRepository>(),
    ),
  );

  getIt.registerLazySingleton<UpdatePasswordUsecase>(
    () => UpdatePasswordUsecase(profileRepository: getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton(
    () => AddAddressUsecase(profileRepository: getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetUserAddressUsecase(profileRepository: getIt<ProfileRepository>()),
  );

  /// -------- Bloc ---------
  ///
  getIt.registerLazySingleton<GetProfileBloc>(() => GetProfileBloc(
        getUserProfileUsecase: getIt<GetUserProfileUsecase>(),
      ));

  getIt.registerLazySingleton<UpdateUserProfileBloc>(
    () => UpdateUserProfileBloc(
      updateUserProfileUsecase: getIt<UpdateUserProfileUsecase>(),
    ),
  );

  getIt.registerLazySingleton<UpdatePasswordBloc>(
    () => UpdatePasswordBloc(
      updatePasswordUsecase: getIt<UpdatePasswordUsecase>(),
    ),
  );

  getIt.registerLazySingleton<GetAddressBlocBloc>(
    () => GetAddressBlocBloc(
      getUserAddressUsecase: getIt<GetUserAddressUsecase>(),
    ),
  );

  getIt.registerLazySingleton<AddAddressBloc>(
    () => AddAddressBloc(addAddressUsecase: getIt<AddAddressUsecase>()),
  );

  /// -------- Cubit ---------
  getIt.registerLazySingleton<AddAddressCubit>(() => AddAddressCubit());
}
