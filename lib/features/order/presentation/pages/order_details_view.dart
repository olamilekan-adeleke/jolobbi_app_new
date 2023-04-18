import 'package:flutter/material.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/utils.dart';
import '../../data/datasources/order_remote_data_source.dart';
import '../../domain/entities/order_entity.dart';
import '../widgets/order_details/order_payment_type_widget.dart';
import '../widgets/order_details/order_user_and_deliver_details_widget.dart';
import '../widgets/order_details/order_fee_break_down_widget.dart';
import '../widgets/order_details/order_item_widget.dart';
import '../widgets/order_details/order_process_widget.dart';

class OrderDetailsView extends StatelessWidget {
  static const String routeName = '/order-details';

  final OrderEntity order;
  const OrderDetailsView(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          verticalSpace(20),
          const AppBarWidget("Order Details"),
          verticalSpace(20),
          OrderItemWidget(order),
          verticalSpace(20),
          OrderUserAndDeliveryDetailsWidget(order),
          verticalSpace(10),
          Divider(color: kcSoftTextColor.withOpacity(0.5)),
          verticalSpace(10),
          OrderPaymentMethodWidget(order),
          verticalSpace(10),
          Divider(color: kcSoftTextColor.withOpacity(0.5)),
          verticalSpace(10),
          OrderBreakDownWidget(order),
          verticalSpace(10),
          Divider(color: kcSoftTextColor.withOpacity(0.5)),
          verticalSpace(10),
          StreamBuilder<OrderEntity>(
            stream: SetUpLocators.getIt<OrderRemoteDataSource>()
                .getOrderStreamById(order.orderId),
            builder: (context, AsyncSnapshot<OrderEntity> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: LoadingIndicatorWidget());
              } else if (snapshot.hasError) {
                return CustomErrorWidget(
                  useFlex: false,
                  message: '${snapshot.error}',
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                LoggerHelper.log(snapshot.data!.toString());
                return OrderProcessWidget(key: UniqueKey(), snapshot.data!);
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
