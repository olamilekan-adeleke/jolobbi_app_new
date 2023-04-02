// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../cores/firebase_helper/firebase_helper.dart';
import '../../../profile/domain/entities/address_entity.dart';
import '../../../profile/domain/entities/user_details_entity.dart';
import 'cart_item_formz.dart';

/// Below are the order status
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
    this.address,
    this.userDetails,
    this.deliveryFee,
    this.serviceFee,
    List<CartItemFormz>? items,
  }) : items = items ?? const <CartItemFormz>[];

  final List<CartItemFormz> items;
  final AddressEntity? address;
  final UserDetailsEntity? userDetails;
  final int? deliveryFee;
  final int? serviceFee;

  String get orderId => const Uuid().v4();
  List<String> get vendors => items.map((e) => e.shopId.value).toSet().toList();
  List<String> get vendorsNames => items.map((e) => e.shopName.value).toList();

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
    return items.isNotEmpty &&
        address != null &&
        userDetails != null &&
        deliveryFee != null &&
        serviceFee != null;
  }

  Map<String, dynamic> _eachShopFee() {
    final Map<String, dynamic> map = {};

    for (var element in items) {
      final shopId = element.shopId.value;
      final shopName = element.shopName.value;
      final shopFee = element.getTotal;

      map.update(shopId, (value) {
        return {
          'shopName': shopName,
          'shopFee': (value['shopFee'] ?? 0) + shopFee,
        };
      }, ifAbsent: () {
        return {'shopName': shopName, 'shopFee': shopFee};
      });
    }

    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address?.toMap(),
      'deliveryFee': deliveryFee,
      'hasRated': false,
      'items': items.map((e) => e.toMap()).toList(),
      'orderId': orderId,
      'orderStatus': 'pre-processing',
      'serviceFee': serviceFee,
      'timestamp': FirebaseHelper().timestamp,
      'totalFee': totalFee,
      'userDetails': userDetails?.toMap(),
      'userId': userDetails?.userId,
      'vendors': vendors,
      'vendorsNames': vendorsNames,
      'eachShopFee': _eachShopFee(),
    };
  }

  @override
  List<Object?> get props =>
      [items, address, userDetails, deliveryFee, serviceFee];

  OrderFormzModel copyWith({
    List<CartItemFormz>? items,
    AddressEntity? address,
    UserDetailsEntity? userDetails,
    int? deliveryFee,
    int? serviceFee,
  }) {
    return OrderFormzModel(
      items: items ?? this.items,
      address: address ?? this.address,
      userDetails: userDetails ?? this.userDetails,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      serviceFee: serviceFee ?? this.serviceFee,
    );
  }
}
