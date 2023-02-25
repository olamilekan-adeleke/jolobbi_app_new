import 'package:flutter/material.dart';

import '../../../../../../cores/constants/color.dart';
import '../../../../../../cores/utils/utils.dart';
import '../../../../../cores/components/components.dart';

class MenuItemDescriptionWidget extends StatelessWidget {
  // final MenuItemEntity menuItem;
  const MenuItemDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          verticalSpace(15),
          TextWidget(
            'Our Cheeseburger is a signature flame-grilled beef patty topped with a simple layer of melted American cheese, crinkle cut pickles, yellow mustard, and ketchup on a toasted sesame seed bun. ',
            fontSize: sp(14),
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.left,
          ),
          verticalSpace(20),
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
          const AddOnItemWidget(),
          verticalSpace(20),
          TextWidget(
            "Extra Items",
            fontSize: sp(16),
            fontWeight: FontWeight.w500,
          ),
          const Divider(color: kcGrey200),
          const ExtraItemWidget(),
          verticalSpace(20),
          Button(text: "Add to Cart", onTap: () {}),
          verticalSpace(40),
        ],
      ),
    );
  }
}

class AddOnItemWidget extends StatelessWidget {
  // final List<MenuAddOnEntity> addOns;

  const AddOnItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        // final MenuAddOnEntity addOn = addOns[index];

        return Container(
          margin: EdgeInsets.only(bottom: h(10)),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(sr(5)),
                child: ImageWidget(
                  imageUrl:
                      "https://tfc.com.ng/wp-content/uploads/2021/08/Chicken-Burger.jpeg",
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
                      "Burger",
                      fontSize: sp(16),
                      fontWeight: FontWeight.w400,
                    ),
                    TextWidget(
                      "X 1",
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
  // final List<MenuExtraEntity> extras;

  const ExtraItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        // final MenuExtraEntity extra = extras[index];

        return _ExtraItemWidget();
      },
    );
  }
}

class _ExtraItemWidget extends StatelessWidget {
  _ExtraItemWidget({Key? key}) : super(key: key);

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
                  "https://tfc.com.ng/wp-content/uploads/2021/08/Chicken-Burger.jpeg",
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
                  "Extra Burger",
                  fontSize: sp(16),
                  fontWeight: FontWeight.w400,
                ),
                TextWidget(
                  currencyFormatter(1200),
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
