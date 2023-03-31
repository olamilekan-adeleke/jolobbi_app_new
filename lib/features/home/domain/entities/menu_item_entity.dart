// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MenuItemEntity extends Equatable {
  const MenuItemEntity({
    required this.id,
    required this.addOns,
    required this.extras,
    required this.rating,
    required this.description,
    required this.name,
    required this.shopId,
    required this.shopName,
    required this.images,
    required this.likeCount,
    required this.price,
    required this.prepTime,
    required this.ratingCount,
    required this.type,
    required this.cuisine,
    required this.isAvailable,
  });

  final String id;
  final List<MenuAddOnEntity> addOns;
  final List<MenuExtraEntity> extras;
  final double rating;
  final String description;
  final String name;
  final String shopId;
  final String shopName;
  final List<String> images;
  final int likeCount;
  final int price;
  final int prepTime;
  final int ratingCount;
  final String type;
  final String cuisine;
  final bool isAvailable;

  @override
  List<Object?> get props => [
        id,
        addOns,
        extras,
        rating,
        description,
        name,
        shopId,
        shopName,
        images,
        likeCount,
        price,
        ratingCount,
        type,
        isAvailable,
      ];
}

class MenuAddOnEntity extends Equatable {
  const MenuAddOnEntity({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  final String name;
  final int price;
  final String image;
  final int quantity;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [name, price, image, quantity];
}

class MenuExtraEntity extends Equatable {
  const MenuExtraEntity({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  final String name;
  final int price;
  final String image;
  final int quantity;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [name, price, image, quantity];

  MenuExtraEntity copyWith({
    String? name,
    int? price,
    String? image,
    int? quantity,
  }) {
    return MenuExtraEntity(
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}
