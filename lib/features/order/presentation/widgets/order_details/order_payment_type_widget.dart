import 'package:flutter/material.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../data/models/order_model.dart';
import '../../../domain/entities/order_entity.dart';

class OrderPaymentMethodWidget extends StatelessWidget {
  final OrderEntity order;
  const OrderPaymentMethodWidget(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sw(99),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                "Payment Method",
                fontWeight: FontWeight.w500,
                fontSize: sp(18),
              ),
              verticalSpace(5),
              TextWidget(
                order.paymentMethod.getFormattedName,
                fontSize: sp(18),
                fontWeight: FontWeight.w400,
                textColor: kcSoftTextColor.withOpacity(0.8),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          if (order.paymentMethod == OrderPaymentMethod.bankTransfer)
            Column(
              children: [
                verticalSpace(15),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: ImageWidget(
                      height: h(50),
                      width: w(60),
                      imageTypes: ImageTypes.network,
                      imageUrl: '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                verticalSpace(5),
                TextWidget(
                  "Tap To Add Bank Transfer Receipt for",
                  fontSize: sp(18),
                  fontWeight: FontWeight.w400,
                  textColor: kcSoftTextColor.withOpacity(0.8),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
