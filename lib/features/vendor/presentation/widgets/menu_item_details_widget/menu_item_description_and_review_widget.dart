import 'package:flutter/material.dart';

import '../../../../../../cores/constants/color.dart';
import '../../../../../../cores/utils/utils.dart';
import '../../../../../cores/components/components.dart';
import '../../../../home/domain/entities/menu_item_entity.dart';

class MenuItemDescriptionWidget extends StatelessWidget {
  final MenuItemEntity menuItem;
  const MenuItemDescriptionWidget(this.menuItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          verticalSpace(15),
          TextWidget(
            menuItem.description,
            fontSize: sp(14),
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.left,
          ),
          verticalSpace(20),
          Visibility(
            visible: menuItem.addOns.isNotEmpty,
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
                AddOnItemWidget(menuItem.addOns),
                verticalSpace(20),
              ],
            ),
          ),
          Visibility(
            visible: menuItem.extras.isNotEmpty,
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
                ExtraItemWidget(menuItem.extras),
                verticalSpace(20),
              ],
            ),
          ),
          Button(text: "Add to Cart", onTap: () {}),
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

  const ExtraItemWidget(this.extras, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        final MenuExtraEntity extra = extras[index];

        return _ExtraItemWidget(extra);
      },
    );
  }
}

class _ExtraItemWidget extends StatelessWidget {
  final MenuExtraEntity extra;
  _ExtraItemWidget(this.extra, {Key? key}) : super(key: key);

  final ValueNotifier<int> _countNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: h(10)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(sr(5)),
            child: ImageWidget(
              imageUrl:
                 extra.image,
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
                ),
                TextWidget(
                  currencyFormatter(extra.price),
                  fontSize: sp(14),
                  fontWeight: FontWeight.w400,
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
                  onTap: () {
                    if (_countNotifier.value <= 0) return;
                    _countNotifier.value--;
                  },
                  child: Icon(
                    Icons.remove_circle_outline_outlined,
                    color: kcPrimaryColor,
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
                    );
                  },
                ),
                horizontalSpace(),
                GestureDetector(
                  onTap: () {
                    if (_countNotifier.value >= 10) return;
                    _countNotifier.value++;
                  },
                  child: Icon(
                    Icons.add_circle_outline_outlined,
                    color: kcPrimaryColor,
                    size: sr(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
