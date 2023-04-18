import 'package:flutter/material.dart';
import 'package:jolobbi_app_new/app/locator.dart';

import '../../../../../../cores/constants/color.dart';
import '../../../../../../cores/utils/utils.dart';
import '../../../../../cores/components/components.dart';
import '../../../../home/domain/entities/menu_item_entity.dart';
import '../../../../menu_cart/presentation/cubit/cart_items_cubit.dart';
import '../../../../menu_cart/presentation/formz/cart_item_formz.dart';

class MenuItemDescriptionWidget extends StatefulWidget {
  final MenuItemEntity menuItem;
  const MenuItemDescriptionWidget(this.menuItem, {super.key});

  @override
  State<MenuItemDescriptionWidget> createState() =>
      _MenuItemDescriptionWidgetState();
}

class _MenuItemDescriptionWidgetState extends State<MenuItemDescriptionWidget> {
  final CartItemCubit _cartItemCubit = SetUpLocators.getIt<CartItemCubit>();
  final ValueNotifier<CartItemFormz> _cartItemFormzState =
      ValueNotifier(CartItemFormz());

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    _cartItemFormzState.value = _cartItemFormzState.value.copyWithData(
      id: widget.menuItem.id,
      name: widget.menuItem.name,
      price: widget.menuItem.price,
      quantity: 1,
      images: widget.menuItem.images,
      addOns: widget.menuItem.addOns,
      description: widget.menuItem.description,
      shopId: widget.menuItem.shopId,
      shopName: widget.menuItem.shopName,
      prepTime: widget.menuItem.prepTime,
      type: widget.menuItem.type,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          verticalSpace(15),
          TextWidget(
            widget.menuItem.description,
            fontSize: sp(14),
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.left,
          ),
          verticalSpace(20),
          Visibility(
            visible: widget.menuItem.addOns.isNotEmpty,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  "Add On Items",
                  fontSize: sp(16),
                  fontWeight: FontWeight.w500,
                ),
                TextWidget(
                  "Items are add for free",
                  fontSize: sp(14),
                  fontWeight: FontWeight.w300,
                ),
                verticalSpace(5),
                AddOnItemWidget(widget.menuItem.addOns),
                verticalSpace(20),
              ],
            ),
          ),
          Visibility(
            visible: widget.menuItem.extras.isNotEmpty,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  "Extra Items",
                  fontSize: sp(16),
                  fontWeight: FontWeight.w500,
                ),
                const Divider(color: kcGrey200),
                ExtraItemWidget(
                  widget.menuItem.extras,
                  cartItemFormzState: _cartItemFormzState,
                ),
                verticalSpace(20),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _cartItemFormzState,
            builder: (_, CartItemFormz cartItemFormz, __) {
              return Button(
                active: cartItemFormz.isValid && widget.menuItem.isAvailable,
                text: "Add to Cart",
                onTap: () {
                  String message = _cartItemCubit.addToCart(cartItemFormz);

                  SnackBarService.showSuccessSnackBar(
                    context: context,
                    message: message,
                  );

                  _cartItemFormzState.value = CartItemFormz();
                  initData();
                },
              );
            },
          ),
          verticalSpace(40),
        ],
      ),
    );
  }
}

class AddOnItemWidget extends StatelessWidget {
  final List<MenuAddOnEntity> addOns;

  const AddOnItemWidget(this.addOns, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        final MenuAddOnEntity addOn = addOns[index];

        return Container(
          margin: EdgeInsets.only(bottom: h(10)),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(sr(5)),
                child: ImageWidget(
                  imageUrl: addOn.image,
                  imageTypes: ImageTypes.network,
                  height: h(45),
                  width: w(45),
                ),
              ),
              horizontalSpace(15),
              SizedBox(
                height: h(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      addOn.name,
                      fontSize: sp(16),
                      fontWeight: FontWeight.w400,
                    ),
                    TextWidget(
                      "X ${addOn.quantity}",
                      fontSize: sp(14),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}

class ExtraItemWidget extends StatelessWidget {
  final List<MenuExtraEntity> extras;
  final ValueNotifier<CartItemFormz> cartItemFormzState;

  const ExtraItemWidget(
    this.extras, {
    Key? key,
    required this.cartItemFormzState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: extras.length,
      itemBuilder: (context, index) {
        final MenuExtraEntity extra = extras[index];

        return _ExtraItemWidget(extra, cartItemFormzState: cartItemFormzState);
      },
    );
  }
}

class _ExtraItemWidget extends StatelessWidget {
  final MenuExtraEntity extra;
  final ValueNotifier<CartItemFormz> cartItemFormzState;

  _ExtraItemWidget(
    this.extra, {
    Key? key,
    required this.cartItemFormzState,
  }) : super(key: key);

  final ValueNotifier<int> _countNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: extra.isAvailable == false,
      child: Container(
        margin: EdgeInsets.only(bottom: h(10)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(sr(5)),
              child: ImageWidget(
                imageUrl: extra.image,
                imageTypes: ImageTypes.network,
                height: h(45),
                width: w(45),
              ),
            ),
            horizontalSpace(15),
            SizedBox(
              height: h(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    extra.name,
                    fontSize: sp(16),
                    fontWeight: FontWeight.w400,
                    textColor: extra.isAvailable ? null : kcGrey400,
                  ),
                  TextWidget(
                    currencyFormatter(extra.price),
                    fontSize: sp(14),
                    fontWeight: FontWeight.w400,
                    textColor: extra.isAvailable ? null : kcGrey400,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(5)),
              decoration: BoxDecoration(
                border: Border.all(color: kcGrey400),
                borderRadius: BorderRadius.circular(sr(5)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: decrement,
                    child: Icon(
                      Icons.remove_circle_outline_outlined,
                      color: extra.isAvailable ? kcPrimaryColor : kcGrey400,
                      size: sr(20),
                    ),
                  ),
                  horizontalSpace(),
                  ValueListenableBuilder(
                    valueListenable: _countNotifier,
                    builder: (_, int count, __) {
                      return TextWidget(
                        "$count",
                        fontSize: sp(14),
                        fontWeight: FontWeight.w400,
                        textColor: extra.isAvailable ? null : kcGrey400,
                      );
                    },
                  ),
                  horizontalSpace(),
                  GestureDetector(
                    onTap: increment,
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      color: extra.isAvailable ? kcPrimaryColor : kcGrey400,
                      size: sr(20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void increment() {
    if (_countNotifier.value >= 10) return;
    _countNotifier.value++;

    MenuExtraEntity extraEntity = MenuExtraEntity(
      name: extra.name,
      price: extra.price,
      quantity: _countNotifier.value,
      image: extra.image,
      isAvailable: extra.isAvailable,
    );

    List<MenuExtraEntity> extras = cartItemFormzState.value.extras;

    cartItemFormzState.value = cartItemFormzState.value.copyWith(
      extras: [...extras, extraEntity],
    );
  }

  void decrement() {
    if (_countNotifier.value <= 0) return;
    _countNotifier.value--;

    if (_countNotifier.value == 0) {
      List<MenuExtraEntity> extras =
          cartItemFormzState.value.extras.where(((element) {
        return element.name != extra.name;
      })).toList();

      cartItemFormzState.value = cartItemFormzState.value.copyWith(
        extras: extras,
      );
    } else {
      MenuExtraEntity extraEntity = cartItemFormzState.value.extras.firstWhere(
        ((element) => element.name == extra.name),
      );
      final int index = cartItemFormzState.value.extras.indexOf(extraEntity);
      extraEntity = extraEntity.copyWith(quantity: _countNotifier.value);

      cartItemFormzState.value = cartItemFormzState.value.copyWith(
        extras: cartItemFormzState.value.extras
          ..removeAt(index)
          ..insert(index, extraEntity),
      );
    }
  }
}
