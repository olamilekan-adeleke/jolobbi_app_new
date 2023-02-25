import 'package:flutter/material.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/utils.dart';

class VendorAboutInfoWidget extends StatelessWidget {
  const VendorAboutInfoWidget({super.key});

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
              Icon(
                Icons.location_on,
                color: kcPrimaryColor,
                size: w(20),
              ),
              horizontalSpace(),
              TextWidget(
                "542 5th Ave, New York, NY 10036, USA",
                fontSize: sp(14),
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
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: kcPrimaryColor,
                size: w(20),
              ),
              horizontalSpace(),
              TextWidget(
                "Monday 10:00 AM - 10:00 PM",
                fontSize: sp(14),
              ),
            ],
          ),
          verticalSpace(),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: kcPrimaryColor,
                size: w(20),
              ),
              horizontalSpace(),
              TextWidget(
                "Tuesday 10:00 AM - 10:00 PM",
                fontSize: sp(14),
              ),
            ],
          ),
          verticalSpace(),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: kcPrimaryColor,
                size: w(20),
              ),
              horizontalSpace(),
              TextWidget(
                "Wednesday 10:00 AM - 10:00 PM",
                fontSize: sp(14),
              ),
            ],
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
              Icon(
                Icons.phone,
                color: kcPrimaryColor,
                size: w(20),
              ),
              horizontalSpace(),
              TextWidget(
                "+1 234 567 890",
                fontSize: sp(14),
              ),
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
              Icon(
                Icons.email,
                color: kcPrimaryColor,
                size: w(20),
              ),
              horizontalSpace(),
              TextWidget(
                "shop@gmail.com",
                fontSize: sp(14),
              ),
            ],
          ),
          verticalSpace(40),
        ],
      ),
    );
  }
}
