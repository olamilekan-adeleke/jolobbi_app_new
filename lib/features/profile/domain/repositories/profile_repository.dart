import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../data/models/address_model.dart';
import '../entities/address_entity.dart';
import '../entities/user_details_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failures, UserDetailsEntity>> getProfile();

  Future<Either<Failures, BaseEntity>> updateProfile(Map<String, dynamic> data);

  Future<Either<Failures, BaseEntity>> updatePassword(String email);

  Future<Either<Failures, BaseEntity>> addAddress(AddressModel data);

  Future<Either<Failures, List<AddressEntity>>> getAddress();
}
