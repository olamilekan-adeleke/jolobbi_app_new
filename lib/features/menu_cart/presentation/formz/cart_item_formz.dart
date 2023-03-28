import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../cores/utils/formz_validator/required_formz_validator.dart';
import '../../../home/domain/entities/menu_item_entity.dart';

class CartItemFormz extends Equatable with FormzMixin {
  CartItemFormz({
    this.id = const Required.pure(),
    this.description = const Required.pure(),
    this.name = const Required.pure(),
    this.shopId = const Required.pure(),
    this.shopName = const Required.pure(),
    this.price = const RequiredInt.pure(),
    this.quantity = const RequiredInt.pure(0),
    this.type = const Required.pure(),
    List<Required>? images,
    List<MenuAddOnEntity>? addOns,
    List<MenuExtraEntity>? extras,
  })  : images = images ?? <Required>[],
        addOns = addOns ?? <MenuAddOnEntity>[],
        extras = extras ?? <MenuExtraEntity>[];

  final Required id;
  final List<MenuAddOnEntity> addOns;
  final List<MenuExtraEntity> extras;
  final Required description;
  final Required name;
  final Required shopId;
  final Required shopName;
  final List<Required> images;
  final RequiredInt price;
  final RequiredInt quantity;
  final Required type;

  bool get isValid => status == FormzStatus.valid;
  int get getTotal {
    int total = 0;
    total += (price.value * quantity.value);
    total += extras.fold(0, (previousValue, element) {
      return previousValue + (element.price * quantity.value);
    });

    return total;
  }

  @override
  List<FormzInput> get inputs => [
        id,
        description,
        name,
        shopId,
        shopName,
        price,
        type,
        quantity,
        ...images,
      ];

  CartItemFormz copyWith({
    Required? id,
    List<MenuAddOnEntity>? addOns,
    List<MenuExtraEntity>? extras,
    Required? description,
    Required? name,
    Required? shopId,
    Required? shopName,
    List<Required>? images,
    RequiredInt? price,
    RequiredInt? quantity,
    Required? type,
  }) {
    return CartItemFormz(
      id: id ?? this.id,
      addOns: addOns ?? this.addOns,
      extras: extras ?? this.extras,
      description: description ?? this.description,
      name: name ?? this.name,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      images: images ?? this.images,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      type: type ?? this.type,
    );
  }

  CartItemFormz copyWithQuantity(int quantity) {
    return copyWith(quantity: RequiredInt.dirty(quantity));
  }

  CartItemFormz copyWithData({
    required String id,
    required List<MenuAddOnEntity> addOns,
    required String description,
    required String name,
    required String shopId,
    required String shopName,
    required List<String> images,
    required int price,
    required int prepTime,
    required int quantity,
    required String type,
  }) {
    return CartItemFormz(
      id: Required.dirty(id),
      addOns: addOns,
      extras: const [],
      description: Required.dirty(description),
      name: Required.dirty(name),
      shopId: Required.dirty(shopId),
      shopName: Required.dirty(shopName),
      images: images.map((e) => Required.dirty(e)).toList(),
      price: RequiredInt.dirty(price),
      quantity: RequiredInt.dirty(quantity),
      type: Required.dirty(type),
    );
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
