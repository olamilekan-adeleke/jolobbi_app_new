import 'package:equatable/equatable.dart';

import '../../../../cores/firebase_helper/firebase_helper.dart';
import '../../../order/data/models/order_model.dart';
import '../../../profile/domain/entities/address_entity.dart';
import '../../../profile/domain/entities/user_details_entity.dart';
import 'cart_item_formz.dart';

/// Below are the order status
/// pending
///
/// pre-processing
/// processing
/// processing-done
/// failed
///
/// Status of the order from the vendor
/// preparing
/// enroute
/// delivered
/// rejected

class OrderFormzModel extends Equatable {
  const OrderFormzModel({
    required this.orderId,
    this.address,
    this.userDetails,
    this.deliveryFee,
    this.serviceFee,
    List<CartItemFormz>? items,
    this.paymentMethod = OrderPaymentMethod.bankTransfer,
    this.bankName = '',
    this.accountName = '',
  }) : items = items ?? const <CartItemFormz>[];

  final String orderId;
  final List<CartItemFormz> items;
  final AddressEntity? address;
  final UserDetailsEntity? userDetails;
  final int? deliveryFee;
  final int? serviceFee;
  final OrderPaymentMethod paymentMethod;
  final String bankName;
  final String accountName;

  // String get orderId => _orderId;
  List<String> get vendors => items.map((e) => e.shopId.value).toSet().toList();
  List<String> get vendorsNames {
    return items.map((e) => e.shopName.value).toSet().toList();
  }

  int get subTotal {
    int total = 0;
    total += serviceFee ?? 0;
    total += items.fold(0, (previousValue, element) {
      return previousValue + element.getTotal;
    });
    return total;
  }

  int get totalFee {
    int total = 0;
    total += deliveryFee ?? 0;
    total += serviceFee ?? 0;
    total += items.fold(0, (previousValue, element) {
      return previousValue + element.getTotal;
    });
    return total;
  }

  bool get isValid {
    if (paymentMethod == OrderPaymentMethod.bankTransfer) {
      return items.isNotEmpty &&
          address != null &&
          userDetails != null &&
          deliveryFee != null &&
          serviceFee != null &&
          bankName.isNotEmpty &&
          accountName.isNotEmpty;
    }

    return items.isNotEmpty &&
        address != null &&
        userDetails != null &&
        deliveryFee != null &&
        serviceFee != null;
  }

  Map<String, dynamic> _eachShopFee() {
    final Map<String, Map<String, dynamic>> map = {};

    for (var element in items) {
      final shopId = element.shopId.value;
      final shopName = element.shopName.value;
      final shopFee = element.getTotal;

      map.update(shopId, (value) {
        return {
          'shopName': shopName,
          'shopFee': (value['shopFee'] ?? 0) + shopFee,
          'itemCount': (value['itemCount'] ?? 0) + 1,
        };
      }, ifAbsent: () {
        return {
          'shopName': shopName,
          'shopFee': shopFee,
          'itemCount': 1,
        };
      });
    }

    return map;
  }

  Map<String, dynamic> toMap() {
    final bool isBank = paymentMethod == OrderPaymentMethod.bankTransfer;

    return {
      'address': address?.toMap(),
      'deliveryFee': deliveryFee,
      'hasRated': false,
      'items': items.map((e) => e.toMap()).toList(),
      'orderId': orderId,
      'status': isBank ? "pending" : 'pre-processing',
      'serviceFee': serviceFee,
      'timestamp': FirebaseHelper().timestamp,
      'totalFee': totalFee,
      'userDetails': userDetails?.toMap(),
      'userId': userDetails?.userId,
      'vendors': vendors,
      'vendorsNames': vendorsNames,
      'eachShopFee': _eachShopFee(),
      'statusHistory': [
        if (isBank)
          {'status': 'pending', 'time': DateTime.now()}
        else
          {'status': 'pre-processing', 'time': DateTime.now()}
      ],
      'paymentMethod': paymentMethod.getName,
      'bankPaymentDetails': {'bankName': bankName, 'accountName': accountName}
    };
  }

  OrderFormzModel copyWith({
    String? orderId,
    List<CartItemFormz>? items,
    AddressEntity? address,
    UserDetailsEntity? userDetails,
    int? deliveryFee,
    int? serviceFee,
    OrderPaymentMethod? paymentMethod,
    String? bankName,
    String? accountName,
  }) {
    return OrderFormzModel(
      orderId: orderId ?? this.orderId,
      items: items ?? this.items,
      address: address ?? this.address,
      userDetails: userDetails ?? this.userDetails,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      serviceFee: serviceFee ?? this.serviceFee,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
    );
  }

  @override
  List<Object?> get props => [
        items,
        address,
        userDetails,
        deliveryFee,
        serviceFee,
        paymentMethod,
        bankName,
        accountName,
      ];
}
