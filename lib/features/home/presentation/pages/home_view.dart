import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../widgets/home_app_bar_widget.dart';
import '../widgets/home_fast_food_list_widget.dart';
import '../widgets/home_near_by_fast_food_widget.dart';
import '../widgets/home_search_widget.dart';

class HomeView extends StatelessWidget {
  static const String route = "/home";

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeAppBarWidget(),
          verticalSpace(20),
          const HomeSearchWidget(),
          verticalSpace(20),
          const HomeNearByFastFoodWidget(),
          verticalSpace(20),
          const HomeFastFoodListWidget(),
        ],
      ),
    );
  }
}
