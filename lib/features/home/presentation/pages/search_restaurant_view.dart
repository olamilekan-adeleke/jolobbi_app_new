import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/utils.dart';
import '../../domain/entities/shop_details_entity.dart';
import '../bloc/search_restaurant/search_restaurant_bloc.dart';
import '../widgets/home_fast_food_list_widget.dart';

class SearchRestaurantView extends StatelessWidget {
  static const String route = "/search_restaurant";

  const SearchRestaurantView({super.key});

  static final SearchRestaurantBloc _searchMenuItemBloc =
      SetUpLocators.getIt<SearchRestaurantBloc>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        children: <Widget>[
          const AppBarWidget("Search Restaurant"),
          TextFieldWidget(
            hintText: "Search For Restaurant",
            prefixWidget: const SizedBox(
              child: Icon(Icons.search, color: kcSoftTextColor),
            ),
            onChanged: (val) => _searchMenuItemBloc.add(
              SearchRestaurantEvent(val),
            ),
          ),
          verticalSpace(),
          BlocBuilder<SearchRestaurantBloc, SearchRestaurantState>(
            bloc: _searchMenuItemBloc,
            builder: (context, state) {
              if (state is SearchRestaurantLoading) {
                return const Center(child: LoadingIndicatorWidget());
              } else if (state is SearchRestaurantError) {
                return CustomErrorWidget(
                  message: state.message,
                  showButton: false,
                );
              } else if (state is SearchRestaurantSuccess) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.shops.length,
                  itemBuilder: (context, index) {
                    final ShopDetailsEntity shop = state.shops[index];
                    return BuildFastFoodItem(shop: shop);
                  },
                );
              }

              return Container();
            },
          )
        ],
      ),
    );
  }
}
