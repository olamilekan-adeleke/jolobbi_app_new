import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../widgets/menu_item_details_widget/menu_image_widget.dart';
import '../widgets/menu_item_details_widget/menu_item_info_widget.dart';

class MenuItemDetailsView extends StatelessWidget {
  static const String route = '/menu-item-details-view';

  const MenuItemDetailsView({super.key});

  static List<String> imageUrl = [
    "https://assets.epicurious.com/photos/5c745a108918ee7ab68daf79/6:4/w_3756,h_2504,c_limit/Smashburger-recipe-120219.jpg",
    "https://static.cookist.it/wp-content/uploads/sites/22/2021/09/beef-burger.jpg",
    "https://www.tastingtable.com/img/gallery/what-makes-restaurant-burgers-taste-different-from-homemade-burgers-upgrade/l-intro-1662064407.jpg",
    "https://assets.cntraveller.in/photos/60ba26c0bfe773a828a47146/4:3/w_1440,h_1080,c_limit/Burgers-Mumbai-Delivery.jpg",
    "https://www.safefood.net/getmedia/d81f679f-a5bc-4a16-a592-248d3b1dc803/burger_1.jpg?width=1280&height=720&ext=.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      usePadding: false,
      // useSingleScroll: false,
      body: Column(
        children: <Widget>[
          MenuItemImageWidget(imageUrl),
          Container(
            padding: EdgeInsets.symmetric(horizontal: w(15)),
            color: Colors.white,
            child: const MenuItemInfoWidget(),
          ),
        ],
      ),
    );
  }
}
