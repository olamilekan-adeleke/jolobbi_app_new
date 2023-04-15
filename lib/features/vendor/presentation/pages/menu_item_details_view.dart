import 'package:flutter/material.dart';
import 'package:jolobbi_app_new/app/locator.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../../../home/domain/entities/menu_item_entity.dart';
import '../../data/datasources/vendor_remote_data_source.dart';
import '../widgets/menu_item_details_widget/menu_image_widget.dart';
import '../widgets/menu_item_details_widget/menu_item_info_widget.dart';

class MenuItemDetailsView extends StatefulWidget {
  static const String route = '/menu-item-details-view';
  final MenuItemEntity menuItem;

  const MenuItemDetailsView(this.menuItem, {super.key});

  @override
  State<MenuItemDetailsView> createState() => _MenuItemDetailsViewState();
}

class _MenuItemDetailsViewState extends State<MenuItemDetailsView> {
  final VendorRemoteDataSource vendorRemoteDataSource =
      SetUpLocators.getIt<VendorRemoteDataSource>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      usePadding: false,
      body: StreamBuilder<MenuItemEntity>(
        stream: vendorRemoteDataSource.streamRestaurantFoodItems(
          widget.menuItem.id,
        ),
        builder: (context, AsyncSnapshot<MenuItemEntity> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: sh(60),
              child: const Center(child: LoadingIndicatorWidget()),
            );
          } else if (snapshot.hasError) {
            return SizedBox(
              height: sh(60),
              child: CustomErrorWidget(
                message: snapshot.error.toString(),
                useFlex: false,
                onRetry: () => setState(() {}),
              ),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final MenuItemEntity streamMenuItem = snapshot.data!;

            return Column(
              children: <Widget>[
                MenuItemImageWidget(streamMenuItem.images),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: w(15)),
                  color: Colors.white,
                  child: MenuItemInfoWidget(streamMenuItem),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
