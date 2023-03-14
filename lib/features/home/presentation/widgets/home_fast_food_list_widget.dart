import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/box_shadow.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/location_helper/location_helper.dart';
import '../../../../cores/navigator/navigator.dart';
import '../../../../cores/utils/utils.dart';
import '../../../vendor/presentation/pages/vendor_details_view.dart';
import '../../domain/entities/shop_details_entity.dart';
import '../bloc/bookmark_restaurant/bookmark_restaurant_bloc.dart';
import '../bloc/get_popular_restaurant/get_popular_restaurant_bloc.dart';

class HomeFastFoodListWidget extends StatefulWidget {
  const HomeFastFoodListWidget({super.key});

  @override
  State<HomeFastFoodListWidget> createState() => _HomeFastFoodListWidgetState();
}

class _HomeFastFoodListWidgetState extends State<HomeFastFoodListWidget> {
  static final GetPopularRestaurantBloc _getPopularRestaurantBloc =
      SetUpLocators.getIt<GetPopularRestaurantBloc>();

  @override
  void initState() {
    _getPopularRestaurantBloc.add(const GetPopularRestaurantEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget("Top Rated Restaurant", fontSize: sp(20)),
        verticalSpace(),
        BlocBuilder<GetPopularRestaurantBloc, GetPopularRestaurantState>(
          bloc: _getPopularRestaurantBloc,
          builder: (context, state) {
            if (state is GetPopularRestaurantLoading) {
              return const Center(child: LoadingIndicatorWidget());
            } else if (state is GetPopularRestaurantError) {
              return SizedBox(
                height: sh(40),
                child: CustomErrorWidget(
                  useFlex: false,
                  message: state.message,
                  callback: () => _getPopularRestaurantBloc.add(
                    const GetPopularRestaurantEvent(),
                  ),
                ),
              );
            } else if (state is GetPopularRestaurantSuccess) {
              final List<ShopDetailsEntity> shops = state.shops;

              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: shops.length,
                  itemBuilder: (context, index) {
                    final ShopDetailsEntity shop = shops[index];

                    return GestureDetector(
                      onTap: () => AppRouter.instance.navigateTo(
                        VendorDetailsView.route,
                      ),
                      child: _BuildFastFoodItem(shop: shop),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}

class _BuildFastFoodItem extends StatelessWidget {
  final ShopDetailsEntity shop;
  _BuildFastFoodItem({Key? key, required this.shop}) : super(key: key);

  final BookmarkRestaurantBloc _bookmarkRestaurantBloc =
      SetUpLocators.getIt<BookmarkRestaurantBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookmarkRestaurantBloc, BookmarkRestaurantState>(
      bloc: _bookmarkRestaurantBloc,
      listener: (context, state) {
        if (state is BookmarkRestaurantSuccess) {
          SnackBarService.showSuccessSnackBar(
            context: context,
            message: state.baseEntity.message,
          );
        } else if (state is BookmarkRestaurantError) {
          SnackBarService.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
      },
      child: Container(
        height: h(95),
        margin: EdgeInsets.only(bottom: h(10)),
        padding: EdgeInsets.only(right: w(10)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: boxShadowHelper,
        ),
        child: Row(
          children: <Widget>[
            ImageWidget(
              imageTypes: ImageTypes.network,
              imageUrl: shop.imageUrl,
              height: h(95),
              width: w(95),
            ),
            horizontalSpace(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: sw(56),
                      child: TextWidget(
                        shop.name,
                        fontSize: sp(18),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    BlocBuilder<BookmarkRestaurantBloc,
                        BookmarkRestaurantState>(
                      bloc: _bookmarkRestaurantBloc,
                      builder: (context, state) {
                        if (state is BookmarkRestaurantLoading) {
                          return const LoadingIndicatorWidget();
                        }
                        return GestureDetector(
                          onTap: () => _bookmarkRestaurantBloc.add(
                            BookmarkRestaurantEvent(shop.id),
                          ),
                          child: Icon(
                            Icons.bookmark_border,
                            color: kcSoftTextColor.withOpacity(0.5),
                            size: sp(20),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                verticalSpace(5),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: kcSoftTextColor.withOpacity(0.5),
                      size: sp(15),
                    ),
                    horizontalSpace(5),
                    SizedBox(
                      width: sw(55),
                      child: TextWidget(
                        shop.address,
                        fontSize: sp(14),
                        fontWeight: FontWeight.w300,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                verticalSpace(5),
                SizedBox(
                  width: sw(61.32),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: kcPrimaryColor, size: sp(15)),
                      horizontalSpace(2),
                      TwoSpanTextWidget(
                        "",
                        "${shop.numberOfLikes} Likes",
                        fontSize: sp(13),
                        fontSize2: sp(12),
                        fontWeight: FontWeight.w400,
                        fontWeight2: FontWeight.w300,
                        textColor2: kcSoftTextColor,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      FutureBuilder(
                        future: LocationHelper().getDistanceFromLatLonInKm(
                          shop.coordinate.latitude,
                          shop.coordinate.longitude,
                        ),
                        builder: (context, AsyncSnapshot<double> snaphot) {
                          double distance = 0;

                          if (snaphot.hasData) distance = snaphot.data ?? 0;

                          return TextWidget(
                            "30 Mins • $distance km",
                            fontSize: sp(14),
                            fontWeight: FontWeight.w400,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
