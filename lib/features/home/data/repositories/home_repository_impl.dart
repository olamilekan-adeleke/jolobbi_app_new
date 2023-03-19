import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/exception/base_exception.dart';
import '../../../../cores/exception/firebase_auth_exception.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/failures/error_text.dart';
import '../../../../cores/utils/logger.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../../domain/entities/shop_details_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  const HomeRepositoryImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failures, BaseEntity>> bookMarkRestaurant(String id) async {
    try {
      final BaseModel result =
          await homeRemoteDataSource.bookMarkRestaurant(id);

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
  Future<Either<Failures, List<MenuItemEntity>>> getFoodMenuByQuery(
    String query,
    String? lastDocId,
  ) async {
    try {
      final List<MenuItemEntity> result =
          await homeRemoteDataSource.getFoodMenuByQuery(query, lastDocId);

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
  Future<Either<Failures, List<ShopDetailsEntity>>>
      getNearByRestaurants() async {
    try {
      final List<ShopDetailsEntity> result =
          await homeRemoteDataSource.getNearByRestaurants();

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
  Future<Either<Failures, List<ShopDetailsEntity>>> getPopularRestaurants(
    String? lastDocId,
  ) async {
    try {
      final List<ShopDetailsEntity> result =
          await homeRemoteDataSource.getPopularRestaurants(lastDocId);

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
  Future<Either<Failures, List<ShopDetailsEntity>>> getRestaurants(
    String? lastDocId,
  ) async {
    try {
      final List<ShopDetailsEntity> result =
          await homeRemoteDataSource.getRestaurants(lastDocId);

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
  Future<Either<Failures, List<ShopDetailsEntity>>> searchRestaurantByQuery(
    String query,
    String? lastDocId,
  ) async {
    try {
      final List<ShopDetailsEntity> result =
          await homeRemoteDataSource.searchRestaurantByQuery(query, lastDocId);

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
