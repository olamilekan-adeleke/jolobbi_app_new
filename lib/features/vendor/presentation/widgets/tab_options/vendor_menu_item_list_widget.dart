import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/navigator/navigator.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../../home/domain/entities/menu_item_entity.dart';
import '../../bloc/get_restaurant_food_item/get_restaurant_food_item_bloc.dart';
import '../../pages/menu_item_details_view.dart';

class VendorMenuItemListWidget extends StatefulWidget {
  final String shopId;
  const VendorMenuItemListWidget(this.shopId, {super.key});

  @override
  State<VendorMenuItemListWidget> createState() =>
      _VendorMenuItemListWidgetState();
}

class _VendorMenuItemListWidgetState extends State<VendorMenuItemListWidget> {
  late final ScrollController _scrollController = ScrollController();

  final GetRestaurantFoodItemBloc _getRestaurantFoodItemBloc =
      SetUpLocators.getIt<GetRestaurantFoodItemBloc>();

  @override
  void initState() {
    _getRestaurantFoodItemBloc.add(GetRestaurantFoodItemEvent(widget.shopId));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getRestaurantFoodItemBloc.add(
          GetRestaurantFoodItemEvent(widget.shopId, shouldGetFreshData: false),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetRestaurantFoodItemBloc, GetRestaurantFoodItemState>(
      bloc: _getRestaurantFoodItemBloc,
      builder: (context, state) {
        if (state is GetRestaurantFoodItemLoading) {
          return const Center(child: LoadingIndicatorWidget());
        } else if (state is GetRestaurantFoodItemError) {
          return CustomErrorWidget(
            message: state.message,
            onRetry: () => _getRestaurantFoodItemBloc.add(
              GetRestaurantFoodItemEvent(widget.shopId),
            ),
            useFlex: false,
          );
        }

        return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(vertical: h(15)),
          separatorBuilder: (context, index) => Divider(
            color: kcSoftTextColor.withOpacity(0.3),
          ),
          shrinkWrap: true,
          itemCount: _getRestaurantFoodItemBloc.menuItemEntities.length,
          itemBuilder: (context, index) {
            final menuItem = _getRestaurantFoodItemBloc.menuItemEntities[index];

            return GestureDetector(
              onTap: () => AppRouter.instance.navigateTo(
                MenuItemDetailsView.route,
                arguments: menuItem,
              ),
              child: _buildMenItem(menuItem),
            );
          },
        );
      },
    );
  }

  Widget _buildMenItem(MenuItemEntity menuItem) {
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
