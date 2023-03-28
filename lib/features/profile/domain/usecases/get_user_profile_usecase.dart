import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/params.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../entities/user_details_entity.dart';
import '../repositories/profile_repository.dart';

class GetUserProfileUsecase
    extends UseCaseFuture<Failures, UserDetailsEntity, NoParams> {
  final ProfileRepository _profileRepository;

  GetUserProfileUsecase({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  @override
  FutureOr<Either<Failures, UserDetailsEntity>> call(NoParams params) async {
    return await _profileRepository.getProfile();
  }
}
