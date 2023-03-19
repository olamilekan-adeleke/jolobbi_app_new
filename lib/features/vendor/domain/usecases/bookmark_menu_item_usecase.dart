import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../repositories/vendor_repository.dart';

class BookmarkMenuItemUsecase
    implements UseCaseFuture<Failures, BaseEntity, String> {
  final VendorRepository vendorRepository;

  const BookmarkMenuItemUsecase({required this.vendorRepository});

  @override
  FutureOr<Either<Failures, BaseEntity>> call(String params) async {
    return await vendorRepository.bookmarkMenuItem(params);
  }
}
