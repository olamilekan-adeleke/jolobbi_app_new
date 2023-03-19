import 'package:flutter/material.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../../home/domain/entities/shop_details_entity.dart';

class VendorAboutInfoWidget extends StatelessWidget {
  final ShopDetailsEntity shop;
  const VendorAboutInfoWidget(this.shop, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextWidget(
            "Location",
            textColor: kcSoftTextColor.withOpacity(0.5),
            fontSize: sp(16),
          ),
          verticalSpace(),
          Row(
            children: [
              Icon(Icons.location_on, color: kcPrimaryColor, size: w(20)),
              horizontalSpace(),
              Flexible(
                child: TextWidget(
                  shop.address,
                  fontSize: sp(14),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          verticalSpace(20),
          TextWidget(
            "Opening Hours",
            textColor: kcSoftTextColor.withOpacity(0.5),
            fontSize: sp(16),
          ),
          verticalSpace(),
          ListView.separated(
            separatorBuilder: (context, index) => verticalSpace(),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: shop.openingHours.length,
            itemBuilder: (context, index) {
              final OpeningHoursEntity openingHours = shop.openingHours[index];

              return Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: kcPrimaryColor,
                    size: w(20),
                  ),
                  horizontalSpace(),
                  TextWidget(
                    "${openingHours.day} ${openingHours.openTime} - ${openingHours.closeTime}",
                    fontSize: sp(14),
                  ),
                ],
              );
            },
          ),
          verticalSpace(20),
          TextWidget(
            "Contact",
            textColor: kcSoftTextColor.withOpacity(0.5),
            fontSize: sp(16),
          ),
          verticalSpace(),
          Row(
            children: [
              Icon(Icons.phone, color: kcPrimaryColor, size: w(20)),
              horizontalSpace(),
              TextWidget(shop.contact.phoneNumber, fontSize: sp(14)),
            ],
          ),
          verticalSpace(20),
          TextWidget(
            "Email Address",
            textColor: kcSoftTextColor.withOpacity(0.5),
            fontSize: sp(16),
          ),
          verticalSpace(),
          Row(
            children: [
              Icon(Icons.email, color: kcPrimaryColor, size: w(20)),
              horizontalSpace(),
              TextWidget(shop.contact.email, fontSize: sp(14)),
            ],
          ),
          verticalSpace(40),
        ],
      ),
    );
  }
}
