import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/utils.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../bloc/search_menu_item/search_menu_item_bloc.dart';

class SearchFoodMenuView extends StatelessWidget {
  static const String route = "/search_food_menu";

  const SearchFoodMenuView({super.key});

  static final SearchMenuItemBloc _searchMenuItemBloc =
      SetUpLocators.getIt<SearchMenuItemBloc>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        children: <Widget>[
          const AppBarWidget("Search Food Menu"),
          TextFieldWidget(
            hintText: "Search For Food",
            prefixWidget: const SizedBox(
              child: Icon(Icons.search, color: kcSoftTextColor),
            ),
            onChanged: (val) => _searchMenuItemBloc.add(
              SearchMenuItemEvent(val),
            ),
          ),
          verticalSpace(),
          BlocBuilder<SearchMenuItemBloc, SearchMenuItemState>(
            bloc: _searchMenuItemBloc,
            builder: (context, state) {
              if (state is SearchMenuItemLoading) {
                return const Center(child: LoadingIndicatorWidget());
              } else if (state is SearchMenuItemError) {
                return SizedBox(
                  height: sh(40),
                  child: CustomErrorWidget(
                    useFlex: false,
                    message: state.message,
                    onRetry: () => _searchMenuItemBloc.add(
                      const SearchMenuItemEvent(''),
                    ),
                  ),
                );
              } else if (state is SearchMenuItemSuccess) {
                final List<MenuItemEntity> menuItems = state.menuItems;

                return Flexible(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => verticalSpace(10),
                    shrinkWrap: true,
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final MenuItemEntity menuItem = menuItems[index];

                      return SearchFoodMenuItem(menuItem);
                    },
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

class SearchFoodMenuItem extends StatelessWidget {
  final MenuItemEntity menuItem;

  const SearchFoodMenuItem(this.menuItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageWidget(
            imageTypes: ImageTypes.network,
            imageUrl: menuItem.images.first,
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
                menuItem.name,
                fontSize: sp(18),
                fontWeight: FontWeight.w600,
              ),
              TextWidget(
                menuItem.description,
                // 'Our Cheeseburger is a signature flame-grilled beef patty topped with a simple layer of melted American cheese, crinkle cut pickles, yellow mustard, and ketchup on a toasted sesame seed bun. ',
                fontSize: sp(14),
                textColor: kcSoftTextColor.withOpacity(0.5),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
              verticalSpace(5),
              TextWidget(
                currencyFormatter(menuItem.price),
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
