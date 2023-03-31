import 'package:fpdart/fpdart.dart';

import '../../../../cores/entity/base_entity.dart';
import '../../../../cores/failures/base.dart';
import '../../../../cores/usecase/usecase_interface.dart';
import '../../presentation/formz/order_formz.dart';
import '../repositories/menu_cart_repository.dart';

class CreateOrderUsecase
    implements UseCaseFuture<Failures, BaseEntity, OrderFormzModel> {
  final MenuCartRepository menuCartRepository;

  const CreateOrderUsecase({required this.menuCartRepository});

  @override
  Future<Either<Failures, BaseEntity>> call(OrderFormzModel order) async {
    return await menuCartRepository.createOrder(order);
  }
}
