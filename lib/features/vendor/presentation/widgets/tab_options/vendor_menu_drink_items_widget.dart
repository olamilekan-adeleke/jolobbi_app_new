import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/navigator/navigator.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../../home/domain/entities/menu_item_entity.dart';
// import '../../bloc/get_restaurant_Drink_item/get_restaurant_drink_item_bloc.dart';
import '../../bloc/get_restaurant_Drink_item/get_restaurant_drink_item_bloc.dart';
import '../../pages/menu_item_details_view.dart';

class VendorMenuDrinkItemListWidget extends StatefulWidget {
  final String shopId;
  const VendorMenuDrinkItemListWidget(this.shopId, {super.key});

  @override
  State<VendorMenuDrinkItemListWidget> createState() =>
      _VendorMenuDrinkItemListWidgetState();
}

class _VendorMenuDrinkItemListWidgetState
    extends State<VendorMenuDrinkItemListWidget> {
  late final ScrollController _scrollController = ScrollController();

  final GetRestaurantDrinkItemBloc _getRestaurantDrinkItemBloc =
      SetUpLocators.getIt<GetRestaurantDrinkItemBloc>();

  @override
  void initState() {
    _getRestaurantDrinkItemBloc.add(GetRestaurantDrinkItemEvent(widget.shopId));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getRestaurantDrinkItemBloc.add(
          GetRestaurantDrinkItemEvent(widget.shopId, shouldGetFreshData: false),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetRestaurantDrinkItemBloc, GetRestaurantDrinkItemState>(
      bloc: _getRestaurantDrinkItemBloc,
      builder: (context, state) {
        if (state is GetRestaurantDrinkItemLoading) {
          return const Center(child: LoadingIndicatorWidget());
        } else if (state is GetRestaurantDrinkItemError) {
          return CustomErrorWidget(
            message: state.message,
            onRetry: () => _getRestaurantDrinkItemBloc.add(
              GetRestaurantDrinkItemEvent(widget.shopId),
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
          itemCount: _getRestaurantDrinkItemBloc.menuItemEntities.length,
          itemBuilder: (context, index) {
            final menuItem =
                _getRestaurantDrinkItemBloc.menuItemEntities[index];

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
