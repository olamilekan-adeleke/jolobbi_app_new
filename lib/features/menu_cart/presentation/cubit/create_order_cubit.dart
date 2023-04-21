import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../order/data/models/order_model.dart';
import '../../../profile/domain/entities/user_details_entity.dart';
import '../formz/cart_item_formz.dart';
import '../formz/order_formz.dart';
import '../../../profile/domain/entities/address_entity.dart';

class CreateOrderCubit extends Cubit<OrderFormzModel> {
  CreateOrderCubit() : super(OrderFormzModel(orderId: const Uuid().v4()));

  void reset() => emit(OrderFormzModel(orderId: const Uuid().v4()));

  void updateOrderId() => emit(state.copyWith(orderId: const Uuid().v4()));

  void addOrderItem(List<CartItemFormz> items) {
    emit(state.copyWith(items: items));
  }

  void addAddress(AddressEntity address) {
    emit(state.copyWith(address: address));
  }

  void addUserDetails(UserDetailsEntity? userDetails) {
    emit(state.copyWith(userDetails: userDetails));
  }

  void addDeliveryFee(int deliveryFee) {
    emit(state.copyWith(deliveryFee: deliveryFee));
  }

  void addServiceFee(int serviceFee) {
    emit(state.copyWith(serviceFee: serviceFee));
  }

  void paymentMethod(OrderPaymentMethod paymentMethod) {
    emit(state.copyWith(
      paymentMethod: paymentMethod,
      bankName: '',
      accountName: '',
    ));
  }

  void addBankName(String bankName) {
    emit(state.copyWith(bankName: bankName));
  }

  void addAccountName(String accountName) {
    emit(state.copyWith(accountName: accountName));
  }
}
