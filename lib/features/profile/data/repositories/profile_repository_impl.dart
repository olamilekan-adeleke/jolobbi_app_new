import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/exception/base_exception.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/failures/error_text.dart';
import '../../../../cores/utils/utils.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/user_details_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/address_model.dart';
import '../models/user_details_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  const ProfileRepositoryImpl({
    required ProfileRemoteDataSource profileRemoteDataSource,
  }) : _profileRemoteDataSource = profileRemoteDataSource;

  @override
  Future<Either<Failures, UserDetailsEntity>> getProfile() async {
    try {
      UserDetailsModel result = await _profileRemoteDataSource.getProfile();

      return Either.right(result);
    } on SocketFailures {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, BaseEntity>> updatePassword(String email) async {
    try {
      final BaseModel result = await _profileRemoteDataSource.updatePassword(
        email,
      );

      return Either.right(result);
    } on SocketFailures {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, BaseEntity>> updateProfile(
    Map<String, dynamic> data,
  ) async {
    try {
      final BaseModel result =
          await _profileRemoteDataSource.updateProfile(data);

      return Either.right(result);
    } on SocketFailures {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, BaseEntity>> addAddress(AddressModel data) async {
    try {
      final BaseModel result = await _profileRemoteDataSource.addAddress(data);

      return Either.right(result);
    } on SocketFailures {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<AddressEntity>>> getAddress() async {
    try {
      final List<AddressEntity> result =
          await _profileRemoteDataSource.getAddress();

      return Either.right(result);
    } on SocketFailures {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }
}
