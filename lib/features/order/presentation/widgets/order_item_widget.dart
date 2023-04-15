import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/navigator/navigator.dart';
import '../../../../cores/utils/utils.dart';
import '../../data/models/order_model.dart';
import '../../domain/entities/order_entity.dart';
import '../pages/order_details_view.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderEntity order;
  const OrderItemWidget(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => AppRouter.instance.navigateTo(
        OrderDetailsView.routeName,
        arguments: order,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget(
                        "Order of ${order.getItemsName}",
                        textColor: Colors.grey.shade700,
                        fontSize: sp(16),
                        fontWeight: FontWeight.w700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(3),
                      TextWidget(
                        DateTimeHelper.formatDateWithTime(
                          order.timestamp.toDate(),
                        ),
                        textColor: Colors.grey.shade700,
                        fontSize: sp(14),
                        fontWeight: FontWeight.w300,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                horizontalSpace(20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(sr(5)),
                  child: ImageWidget(
                    imageTypes: ImageTypes.network,
                    imageUrl: order.items.first.images.first,
                    height: h(35),
                    width: w(35),
                  ),
                ),
              ],
            ),
            verticalSpace(),
            Row(
              children: [
                TwoSpanTextWidget(
                  "Status: ",
                  order.status.getName,
                  textColor: Colors.grey.shade700,
                  textColor2: Colors.yellow.shade900,
                  fontSize: sp(12),
                  fontSize2: sp(12),
                  fontWeight: FontWeight.w400,
                  fontWeight2: FontWeight.w500,
                ),
                const Spacer(),
                TextWidget(
                  "Total: ${currencyFormatter(order.totalFee)}",
                  textColor: Colors.grey.shade700,
                  fontSize: sp(12),
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
