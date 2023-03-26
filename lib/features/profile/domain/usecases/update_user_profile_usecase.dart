import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../repositories/profile_repository.dart';

class UpdateUserProfileUsecase
    extends UseCaseFuture<Failures, BaseEntity, Map<String, dynamic>> {
  final ProfileRepository _profileRepository;

  UpdateUserProfileUsecase({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  @override
  FutureOr<Either<Failures, BaseEntity>> call(
    Map<String, dynamic> params,
  ) async {
    return await _profileRepository.updateProfile(params);
  }
}
