import 'package:flutter/material.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/utils.dart';

class SearchFoodMenuView extends StatelessWidget {
  static const String route = "/search_food_menu";

  const SearchFoodMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        children: <Widget>[
          const AppBarWidget("Search Food Menu"),
          const TextFieldWidget(
            hintText: "Search For Food",
            prefixWidget: SizedBox(
              child: Icon(Icons.search, color: kcSoftTextColor),
            ),
          ),
          verticalSpace(),
          Flexible(
            child: ListView.separated(
              separatorBuilder: (context, index) => verticalSpace(10),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const SearchFoodMenuItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchFoodMenuItem extends StatelessWidget {
  const SearchFoodMenuItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
