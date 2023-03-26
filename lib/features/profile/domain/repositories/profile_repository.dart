import 'package:fpdart/fpdart.dart';
import '../../../../cores/entity/base_entity.dart';

import '../../../../cores/failures/base.dart';
import '../entities/user_details_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failures, UserDetailsEntity>> getProfile();

  Future<Either<Failures, BaseEntity>> updateProfile(Map<String, dynamic> data);

  Future<Either<Failures, BaseEntity>> updatePassword(String email);
}
