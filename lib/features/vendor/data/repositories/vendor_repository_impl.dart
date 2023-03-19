import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/exception/base_exception.dart';
import '../../../../cores/exception/firebase_auth_exception.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/failures/error_text.dart';
import '../../../../cores/utils/logger.dart';
import '../../../home/domain/entities/menu_item_entity.dart';
import '../../domain/repositories/vendor_repository.dart';
import '../datasources/vendor_remote_data_source.dart';

class VendorRepositoryImpl implements VendorRepository {
  final VendorRemoteDataSource vendorRemoteDataSource;

  const VendorRepositoryImpl({required this.vendorRemoteDataSource});

  @override
  Future<Either<Failures, BaseEntity>> bookmarkMenuItem(String id) async {
    try {
      final BaseEntity result =
          await vendorRemoteDataSource.bookmarkMenuItem(id);

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFirebaseException(e.code));
    } on SocketException {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Left(BaseFailures(message: e.message));
      }

      return Left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<MenuItemEntity>>> getRestaurantDrinkItems(
    String id,
    String? lastDocId,
  ) async {
    try {
      final List<MenuItemEntity> result =
          await vendorRemoteDataSource.getRestaurantDrinkItems(id, lastDocId);

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFirebaseException(e.code));
    } on SocketException {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Left(BaseFailures(message: e.message));
      }

      return Left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<MenuItemEntity>>> getRestaurantFoodItems(
    String id,
    String? lastDocId,
  ) async {
    try {
      final List<MenuItemEntity> result =
          await vendorRemoteDataSource.getRestaurantFoodItems(id, lastDocId);

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFirebaseException(e.code));
    } on SocketException {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Left(BaseFailures(message: e.message));
      }

      return Left(BaseFailures(message: e.toString()));
    }
  }
}
