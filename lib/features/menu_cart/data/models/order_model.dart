import '../../../home/data/models/menu_item_model.dart';
import '../../../profile/data/models/address_model.dart';
import '../../../profile/data/models/user_details_model.dart';

class OrderModel {
  const OrderModel({
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

  final List<OrderItemModel> items;
  final AddressModel address;
  final UserDetailsModel userDetails;
  final int deliveryFee;
  final int serviceFee;
  final String orderId;
  final List<String> vendors;
  final List<String> vendorsNames;
  final int totalFee;

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      items: List<OrderItemModel>.from(
        (map['items'] as List<int>).map<OrderItemModel>(
          (x) => OrderItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      userDetails:
          UserDetailsModel.fromMap(map['userDetails'] as Map<String, dynamic>),
      deliveryFee: map['deliveryFee'] as int,
      serviceFee: map['serviceFee'] as int,
      orderId: map['orderId'] as String,
      vendors: List<String>.from((map['vendors'] as List<String>)),
      vendorsNames: List<String>.from((map['vendorsNames'] as List<String>)),
      totalFee: map['totalFee'] as int,
    );
  }
}

class OrderItemModel {
  OrderItemModel({
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
  final List<MenuAddOnModel> addOns;
  final List<MenuExtraModel> extras;
  final String description;
  final String name;
  final String shopId;
  final String shopName;
  final List<String> images;
  final int price;
  final int quantity;
  final String type;

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'] as String,
      addOns: List<MenuAddOnModel>.from(
        (map['addOns'] as List<int>).map<MenuAddOnModel>(
          (x) => MenuAddOnModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      extras: List<MenuExtraModel>.from(
        (map['extras'] as List<int>).map<MenuExtraModel>(
          (x) => MenuExtraModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      description: map['description'] as String,
      name: map['name'] as String,
      shopId: map['shopId'] as String,
      shopName: map['shopName'] as String,
      images: List<String>.from((map['images'] as List<String>)),
      price: map['price'] as int,
      quantity: map['quantity'] as int,
      type: map['type'] as String,
    );
  }
}
