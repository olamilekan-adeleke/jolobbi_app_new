import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/params.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../entities/address_entity.dart';
import '../repositories/profile_repository.dart';

class GetUserAddressUsecase
    implements UseCaseFuture<Failures, List<AddressEntity>, NoParams> {
  final ProfileRepository profileRepository;

  const GetUserAddressUsecase({required this.profileRepository});

  @override
  FutureOr<Either<Failures, List<AddressEntity>>> call(NoParams params) async {
    return await profileRepository.getAddress();
  }
}
