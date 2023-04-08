import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../home/domain/entities/menu_item_entity.dart';
import '../../../profile/domain/entities/address_entity.dart';
import '../../../profile/domain/entities/user_details_entity.dart';
import '../../data/models/order_model.dart';

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
    required this.timestamp,
    required this.status,
    required this.statusHistory,
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
  final Timestamp timestamp;
  final OrderStatus status;
  final List<StatusHistoryEntity> statusHistory;

  String get getItemsName => items.map((e) => e.name).join(', ');

  List<StatusHistoryEntity> get getStatusHistory {
    final List<StatusHistoryEntity> list = [];
    if (status != OrderStatus.rejected || status != OrderStatus.failed) {
      list.addAll(statusHistory);
    }

    final int index = _getValues.indexOf(status);
    if (index == -1) return list;

    for (int i = index + 1; i < _getValues.length; i++) {
      list.add(StatusHistoryEntity(status: _getValues[i]));
    }

    return list;
  }

  OrderStatus get getNextOrderStatus {
    final int index = _getValues.indexOf(status);
    if (index == -1) return status;

    if (index + 1 < _getValues.length) {
      return _getValues[index + 1];
    }

    return status;
  }

  List<OrderStatus> get _getValues => [
        OrderStatus.preProcessing,
        OrderStatus.processing,
        OrderStatus.processingDone,
        OrderStatus.preparing,
        OrderStatus.enroute,
        OrderStatus.delivered,
      ];

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
        timestamp,
        status,
        statusHistory,
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

class StatusHistoryEntity extends Equatable {
  const StatusHistoryEntity({required this.status, this.time, this.reason});

  final OrderStatus status;
  final DateTime? time;
  final String? reason;

  String get name {
    switch (status) {
      case OrderStatus.preProcessing:
        return 'Processing';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.processingDone:
        return 'Processing';
      case OrderStatus.failed:
        return 'Failed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.enroute:
        return 'Enroute';
      case OrderStatus.rejected:
        return 'Rejected';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }

  String get description {
    switch (status) {
      case OrderStatus.preProcessing:
        return 'Your order has been received and will be processed soon';
      case OrderStatus.processing:
        return 'Your order is being validated and processed';
      case OrderStatus.processingDone:
        return 'Your order has being processed and sent to the vendor';
      case OrderStatus.failed:
        return 'Your order failed, Please try again';
      case OrderStatus.preparing:
        return 'Your order is being prepared by the vendor';
      case OrderStatus.enroute:
        return 'Your order is on the way to your location, Please ensure you are available to receive your order';
      case OrderStatus.rejected:
        return 'Your order has been rejected';
      case OrderStatus.delivered:
        return 'Your order has been delivered';
    }
  }

  IconData get icon {
    switch (status) {
      case OrderStatus.preProcessing:
        return CupertinoIcons.paperplane;
      case OrderStatus.processing:
        return Icons.lan_outlined;
      case OrderStatus.processingDone:
        return CupertinoIcons.cube_box;
      case OrderStatus.failed:
        return Icons.error_outline;
      case OrderStatus.preparing:
        return Icons.dinner_dining_outlined;
      case OrderStatus.enroute:
        return Icons.delivery_dining_rounded;
      case OrderStatus.rejected:
        return Icons.hourglass_empty;
      case OrderStatus.delivered:
        return Icons.done_all;
    }
  }

  @override
  List<Object?> get props => [status, time, reason];
}
