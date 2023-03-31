import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/menu_item_entity.dart';
import '../../../profile/domain/entities/address_entity.dart';
import '../../../profile/domain/entities/user_details_entity.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    required this.items,
    required this.address,
    required this.userDetails,
    required this.deliveryFee,
    required this.serviceFee,
    required this.orderId,
    required this.vendors,
    required this.vendorsNames,
    required this.totalFee,
  });

  final List<OrderItemEntity> items;
  final AddressEntity address;
  final UserDetailsEntity userDetails;
  final int deliveryFee;
  final int serviceFee;
  final String orderId;
  final List<String> vendors;
  final List<String> vendorsNames;
  final int totalFee;

  @override
  List<Object?> get props => [
        items,
        address,
        userDetails,
        deliveryFee,
        serviceFee,
        orderId,
        vendors,
        vendorsNames,
        totalFee,
      ];
}

class OrderItemEntity extends Equatable {
  const OrderItemEntity({
    required this.id,
    required this.addOns,
    required this.extras,
    required this.description,
    required this.name,
    required this.shopId,
    required this.shopName,
    required this.images,
    required this.price,
    required this.quantity,
    required this.type,
  });

  final String id;
  final List<MenuAddOnEntity> addOns;
  final List<MenuExtraEntity> extras;
  final String description;
  final String name;
  final String shopId;
  final String shopName;
  final List<String> images;
  final int price;
  final int quantity;
  final String type;

  int get getTotal {
    int total = 0;
    total += (price * quantity);
    total += extras.fold(0, (previousValue, element) {
      return previousValue + (element.price * quantity);
    });

    return total;
  }

  @override
  List<Object?> get props => [
        id,
        addOns,
        extras,
        description,
        name,
        shopId,
        shopName,
        images,
        price,
        quantity,
        type,
      ];
}
