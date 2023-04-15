import 'package:flutter/material.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../domain/entities/order_entity.dart';

class OrderUserAndDeliveryDetailsWidget extends StatelessWidget {
  final OrderEntity order;

  const OrderUserAndDeliveryDetailsWidget(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        horizontalSpace(double.infinity),
        TextWidget(
          "User Details",
          fontSize: sp(18),
          fontWeight: FontWeight.w500,
        ),
        verticalSpace(),
        TextWidget(
          order.userDetails.fullName,
          fontWeight: FontWeight.w700,
          fontSize: sp(18),
        ),
        TextWidget(
          order.userDetails.phoneNumber,
          fontSize: sp(18),
          fontWeight: FontWeight.w400,
          textColor: kcSoftTextColor.withOpacity(0.8),
          textAlign: TextAlign.start,
        ),
        TextWidget(
          order.userDetails.email,
          fontSize: sp(18),
          fontWeight: FontWeight.w400,
          textColor: kcSoftTextColor.withOpacity(0.8),
          textAlign: TextAlign.start,
        ),
        verticalSpace(10),
        Divider(color: kcSoftTextColor.withOpacity(0.5)),
        verticalSpace(10),
        TextWidget(
          "Delivery Address",
          fontSize: sp(18),
          fontWeight: FontWeight.w500,
        ),
        verticalSpace(),
        TextWidget(
          order.address.region,
          fontWeight: FontWeight.w700,
          fontSize: sp(18),
        ),
        TextWidget(
          order.address.fullAddress,
          fontSize: sp(18),
          fontWeight: FontWeight.w400,
          textColor: kcSoftTextColor.withOpacity(0.8),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
