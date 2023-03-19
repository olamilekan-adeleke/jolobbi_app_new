import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../../domain/entities/shop_details_entity.dart';
import '../bloc/get_nearby_restaurant/get_nearby_restaurant_bloc.dart';

class HomeNearByFastFoodWidget extends StatefulWidget {
  const HomeNearByFastFoodWidget({super.key});

  @override
  State<HomeNearByFastFoodWidget> createState() =>
      _HomeNearByFastFoodWidgetState();
}

class _HomeNearByFastFoodWidgetState extends State<HomeNearByFastFoodWidget> {
  final GetNearbyRestaurantBloc getNearbyRestaurantBloc =
      SetUpLocators.getIt<GetNearbyRestaurantBloc>();

  @override
  void initState() {
    getNearbyRestaurantBloc.add(const GetNearbyRestaurantEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget("Nearby Restaurants", fontSize: sp(20)),
        verticalSpace(),
        SizedBox(
          height: h(122),
          child: BlocBuilder<GetNearbyRestaurantBloc, GetNearbyRestaurantState>(
            bloc: getNearbyRestaurantBloc,
            builder: (context, state) {
              if (state is GetNearbyRestaurantLoading) {
                return const Center(child: LoadingIndicatorWidget());
              } else if (state is GetNearbyRestaurantError) {
                return SizedBox(
                  height: sh(20),
                  child: CustomErrorWidget(
                    useFlex: false,
                    message: state.message,
                    onRetry: () => getNearbyRestaurantBloc.add(
                      const GetNearbyRestaurantEvent(),
                    ),
                  ),
                );
              } else if (state is GetNearbyRestaurantSuccess) {
                return _buildListView(state.shops);
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }

  ListView _buildListView(List<ShopDetailsEntity> shops) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: shops.length,
      itemBuilder: (context, index) {
        final ShopDetailsEntity shop = shops[index];

        return Container(
          width: w(90),
          margin: EdgeInsets.only(right: w(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(sr(15)),
                child: ImageWidget(
                  imageTypes: ImageTypes.network,
                  imageUrl: shop.imageUrl,
                  height: h(85),
                  width: w(85),
                ),
              ),
              verticalSpace(3),
              TextWidget(
                shop.name,
                fontSize: sp(14),
                fontWeight: FontWeight.w400,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
