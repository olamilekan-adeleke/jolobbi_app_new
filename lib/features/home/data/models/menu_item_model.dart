import '../../domain/entities/menu_item_entity.dart';

class MenuItemModel extends MenuItemEntity {
  const MenuItemModel({
    required super.id,
    required super.addOns,
    required super.extras,
    required super.rating,
    required super.description,
    required super.name,
    required super.shopId,
    required super.shopName,
    required super.images,
    required super.likeCount,
    required super.price,
    required super.prepTime,
    required super.ratingCount,
    required super.type,
    required super.cuisine,
    required super.isAvailable,
  });

  factory MenuItemModel.fromMap(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'],
      addOns: (json['addOns'] as List<dynamic>)
          .map((e) => MenuAddOnModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      extras: (json['extras'] as List<dynamic>)
          .map((e) => MenuExtraModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      rating: (json['rating'] as num).toDouble(),
      description: json['description'],
      name: json['name'],
      shopId: json['shopId'],
      shopName: json['shopName'],
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      likeCount: json['likeCount'],
      price: json['price'],
      prepTime: json['prepTime'] ?? 0,
      ratingCount: json['ratingCount'],
      type: json['type'],
      cuisine: json['cuisine'] ?? '',
      isAvailable: json['isAvailable'],
    );
  }
}

class MenuAddOnModel extends MenuAddOnEntity {
  const MenuAddOnModel({
    required super.name,
    required super.price,
    required super.image,
    required super.quantity,
  });

  factory MenuAddOnModel.fromMap(Map<String, dynamic> json) {
    return MenuAddOnModel(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }
}

class MenuExtraModel extends MenuExtraEntity {
  const MenuExtraModel({
    required super.name,
    required super.price,
    required super.image,
    required super.quantity,
  });

  factory MenuExtraModel.fromMap(Map<String, dynamic> json) {
    return MenuExtraModel(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }
}
