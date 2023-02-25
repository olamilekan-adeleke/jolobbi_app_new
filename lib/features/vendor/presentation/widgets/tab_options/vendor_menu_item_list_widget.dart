import 'package:flutter/material.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/navigator/navigator.dart';
import '../../../../../cores/utils/utils.dart';
import '../../pages/menu_item_details_view.dart';

class VendorMenuItemListWidget extends StatelessWidget {
  const VendorMenuItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: h(15)),
      separatorBuilder: (context, index) => Divider(
        color: kcSoftTextColor.withOpacity(0.3),
      ),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => AppRouter.instance.navigateTo(
            MenuItemDetailsView.route,
          ),
          child: _buildMenItem(),
        );
      },
    );
  }

  Widget _buildMenItem() {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageWidget(
            imageTypes: ImageTypes.network,
            imageUrl:
                'https://media-cdn.tripadvisor.com/media/photo-s/18/32/77/f0/photo0jpg.jpg',
            height: h(75),
            width: w(70),
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(
                'Cheeseburger',
                fontSize: sp(18),
                fontWeight: FontWeight.w600,
              ),
              TextWidget(
                'Our Cheeseburger is a signature flame-grilled beef patty topped with a simple layer of melted American cheese, crinkle cut pickles, yellow mustard, and ketchup on a toasted sesame seed bun. ',
                fontSize: sp(14),
                textColor: kcSoftTextColor.withOpacity(0.5),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
              verticalSpace(5),
              TextWidget(
                currencyFormatter(2300),
                fontSize: sp(16),
                // textColor: kcSoftTextColor.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
