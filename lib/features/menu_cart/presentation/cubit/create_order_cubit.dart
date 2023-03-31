import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profile/domain/entities/user_details_entity.dart';
import '../formz/cart_item_formz.dart';
import '../formz/order_formz.dart';
import '../../../profile/domain/entities/address_entity.dart';

class CreateOrderCubit extends Cubit<OrderFormzModel> {
  CreateOrderCubit() : super(const OrderFormzModel());

  void reset() => emit(const OrderFormzModel());

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
}
