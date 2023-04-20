// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../home/data/models/menu_item_model.dart';
import '../../../profile/data/models/address_model.dart';
import '../../../profile/data/models/user_details_model.dart';
import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.items,
    required super.address,
    required super.userDetails,
    required super.deliveryFee,
    required super.serviceFee,
    required super.orderId,
    required super.vendors,
    required super.vendorsNames,
    required super.totalFee,
    required super.timestamp,
    required super.status,
    required super.statusHistory,
    required super.paymentMethod,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      items: List<OrderItemModel>.from(
        (map['items'] as List<dynamic>).map<OrderItemModel>(
          (x) => OrderItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      userDetails:
          UserDetailsModel.fromMap(map['userDetails'] as Map<String, dynamic>),
      deliveryFee: map['deliveryFee'] as int,
      serviceFee: map['serviceFee'] as int,
      orderId: map['orderId'] as String,
      vendors: List<String>.from((map['vendors'] as List<dynamic>)),
      vendorsNames: List<String>.from((map['vendorsNames'] as List<dynamic>)),
      totalFee: map['totalFee'] as int,
      timestamp: map['timestamp'] as Timestamp,
      status: orderStatusMap[map['status']] ?? OrderStatus.preProcessing,
      statusHistory: List<StatusHistoryModel>.from(
        (map['statusHistory'] as List<dynamic>).map<StatusHistoryModel>(
          (x) => StatusHistoryModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      paymentMethod: orderPaymentMethodMap[map['paymentMethod']] ??
          OrderPaymentMethod.unknown,
    );
  }

  static statusToString(OrderStatus status) {}
}

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.addOns,
    required super.extras,
    required super.description,
    required super.name,
    required super.shopId,
    required super.shopName,
    required super.images,
    required super.price,
    required super.quantity,
    required super.type,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'] as String,
      addOns: List<MenuAddOnModel>.from(
        (map['addOns'] as List<dynamic>).map<MenuAddOnModel>(
          (x) => MenuAddOnModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      extras: List<MenuExtraModel>.from(
        (map['extras'] as List<dynamic>).map<MenuExtraModel>(
          (x) => MenuExtraModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      description: map['description'] as String,
      name: map['name'] as String,
      shopId: map['shopId'] as String,
      shopName: map['shopName'] as String,
      images: List<String>.from((map['images'] as List<dynamic>)),
      price: map['price'] as int,
      quantity: map['quantity'] as int,
      type: map['type'] as String,
    );
  }
}

class StatusHistoryModel extends StatusHistoryEntity {
  const StatusHistoryModel({
    required super.status,
    required super.time,
    required super.reason,
  });

  factory StatusHistoryModel.fromMap(Map<String, dynamic> map) {
    return StatusHistoryModel(
      status: orderStatusMap[map['status']] ?? OrderStatus.preProcessing,
      reason: map['reason'],
      time: () {
        if (map['time'] is Timestamp) {
          return (map['time'] as Timestamp).toDate();
        } else if (map['time'] is String) {
          return DateTime.parse(map['time'] as String);
        } else {
          return null;
        }
      }(),
    );
  }
}

class OrderBankPaymentDetailsModel extends OrderBankPaymentDetailsEntity {
  const OrderBankPaymentDetailsModel({
    required super.bankName,
    required super.bankAccountName,
  });

  factory OrderBankPaymentDetailsModel.fromMap(Map<String, dynamic> map) {
    return OrderBankPaymentDetailsModel(
      bankName: map['bankName'] as String,
      bankAccountName: map['bankAccountName'] as String,
    );
  }
}

enum OrderStatus {
  pending,
  preProcessing,
  processing,
  processingDone,
  failed,
  preparing,
  enroute,
  delivered,
  rejected,
}

extension OrderStatusExtention on OrderStatus {
  String get getName =>
      orderStatusMap.entries.firstWhere((element) => element.value == this).key;
}

const Map<String, OrderStatus> orderStatusMap = {
  'pending': OrderStatus.pending,
  'pre-processing': OrderStatus.preProcessing,
  'processing': OrderStatus.processing,
  'processing-done': OrderStatus.processingDone,
  'failed': OrderStatus.failed,
  'preparing': OrderStatus.preparing,
  'enroute': OrderStatus.enroute,
  'delivered': OrderStatus.delivered,
  'rejected': OrderStatus.rejected,
};

enum OrderPaymentMethod { cash, card, wallet, bankTransfer, unknown }

extension OrderPaymentMethodExtention on OrderPaymentMethod {
  String get getName => orderPaymentMethodMap.entries
      .firstWhere((element) => element.value == this)
      .key;

  String get getFormattedName {
    switch (this) {
      case OrderPaymentMethod.cash:
        return 'Cash';
      case OrderPaymentMethod.card:
        return 'Card';
      case OrderPaymentMethod.wallet:
        return 'Wallet';
      case OrderPaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case OrderPaymentMethod.unknown:
        return 'Unknown';
    }
  }
}

const Map<String, OrderPaymentMethod> orderPaymentMethodMap = {
  'cash': OrderPaymentMethod.cash,
  'card': OrderPaymentMethod.card,
  'wallet': OrderPaymentMethod.wallet,
  'bank-transfer': OrderPaymentMethod.bankTransfer,
  'unknown': OrderPaymentMethod.unknown,
};
