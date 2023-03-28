import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../repositories/profile_repository.dart';

class UpdatePasswordUsecase
    extends UseCaseFuture<Failures, BaseEntity, String> {
  final ProfileRepository _profileRepository;

  UpdatePasswordUsecase({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  @override
  FutureOr<Either<Failures, BaseEntity>> call(String params) async {
    return await _profileRepository.updatePassword(params);
  }
}
