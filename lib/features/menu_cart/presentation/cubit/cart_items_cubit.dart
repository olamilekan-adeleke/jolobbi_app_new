import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/utils/formz_validator/required_formz_validator.dart';
import '../../../../cores/utils/utils.dart';
import '../formz/cart_item_formz.dart';

class CartItemsList extends Equatable {
  final List<CartItemFormz> cartItems;

  CartItemsList({List<CartItemFormz>? cartItems})
      : cartItems = cartItems ?? <CartItemFormz>[];

  @override
  List<Object?> get props => [cartItems];

  CartItemsList copyWith({List<CartItemFormz>? cartItems}) {
    return CartItemsList(cartItems: cartItems ?? this.cartItems);
  }
}

class CartItemCubit extends Cubit<CartItemsList> {
  CartItemCubit() : super(CartItemsList());

  void clearCart() => emit(CartItemsList());

  String addToCart(CartItemFormz cartItem) {
    if (state.cartItems.contains(cartItem)) {
      return "Menu item already added to cart";
    }

    emit(state.copyWith(cartItems: [...state.cartItems, cartItem]));
    LoggerHelper.log(state);
    return "Menu item added to cart";
  }

  void removeFromCart(CartItemFormz cartItem) {
    final List<CartItemFormz> items = state.cartItems;
    items.remove(cartItem);

    emit(state.copyWith(cartItems: items));
  }

  void increaseQuantity(CartItemFormz cartItem) {
    final int index = state.cartItems.indexOf(cartItem);
    final CartItemFormz updatedCartItem = cartItem.copyWith(
      quantity: RequiredInt.dirty(cartItem.quantity.value + 1),
    );

    emit(
      state.copyWith(
        cartItems: [
          ...state.cartItems.sublist(0, index),
          updatedCartItem,
          ...state.cartItems.sublist(index + 1),
        ],
      ),
    );
  }

  void decreaseQuantity(CartItemFormz cartItem) {
    final int index = state.cartItems.indexOf(cartItem);
    final CartItemFormz updatedCartItem = cartItem.copyWith(
      quantity: RequiredInt.dirty(cartItem.quantity.value - 1),
    );

    emit(
      state.copyWith(
        cartItems: [
          ...state.cartItems.sublist(0, index),
          updatedCartItem,
          ...state.cartItems.sublist(index + 1),
        ],
      ),
    );
  }
}
