import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../../data/models/address_model.dart';
import '../repositories/profile_repository.dart';

class AddAddressUsecase
    implements UseCaseFuture<Failures, BaseEntity, AddressModel> {
  final ProfileRepository profileRepository;

  const AddAddressUsecase({required this.profileRepository});

  @override
  FutureOr<Either<Failures, BaseEntity>> call(AddressModel params) async {
    return await profileRepository.addAddress(params);
  }
}
