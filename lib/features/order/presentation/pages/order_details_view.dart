import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/utils.dart';
import '../../data/datasources/order_remote_data_source.dart';
import '../../data/models/order_model.dart';
import '../../domain/entities/order_entity.dart';
import '../widgets/order_details/order_payment_type_widget.dart';
import '../widgets/order_details/order_user_and_deliver_details_widget.dart';
import '../widgets/order_details/order_fee_break_down_widget.dart';
import '../widgets/order_details/order_item_widget.dart';
import '../widgets/order_details/order_process_widget.dart';

class OrderDetailsView extends StatefulWidget {
  static const String routeName = '/order-details';

  final OrderEntity order;
  const OrderDetailsView(this.order, {super.key});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  late Stream<OrderEntity> _stream;

  @override
  void initState() {
    _stream = SetUpLocators.getIt<OrderRemoteDataSource>().getOrderStreamById(
      widget.order.orderId,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          verticalSpace(20),
          const AppBarWidget("Order Details"),
          verticalSpace(20),
          OrderItemWidget(widget.order),
          verticalSpace(20),
          Visibility(
            visible:
                widget.order.paymentMethod == OrderPaymentMethod.bankTransfer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                OrderPaymentForBankTransferDetailWidget(widget.order),
                verticalSpace(10),
                Divider(color: kcSoftTextColor.withOpacity(0.5)),
                verticalSpace(10),
              ],
            ),
          ),
          OrderUserAndDeliveryDetailsWidget(widget.order),
          verticalSpace(10),
          Divider(color: kcSoftTextColor.withOpacity(0.5)),
          verticalSpace(10),
          StreamBuilder<OrderEntity>(
              stream: _stream,
              builder: (context, AsyncSnapshot<OrderEntity> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingIndicatorWidget());
                } else if (snapshot.hasError) {
                  return CustomErrorWidget(
                    useFlex: false,
                    message: '${snapshot.error}',
                    onRetry: () => setState(() {}),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  return OrderPaymentMethodWidget(
                    key: UniqueKey(),
                    snapshot.data!,
                  );
                }

                return Container();
              }),
          verticalSpace(10),
          Divider(color: kcSoftTextColor.withOpacity(0.5)),
          verticalSpace(10),
          OrderBreakDownWidget(widget.order),
          verticalSpace(10),
          Divider(color: kcSoftTextColor.withOpacity(0.5)),
          verticalSpace(10),
          StreamBuilder<OrderEntity>(
            stream: _stream,
            builder: (context, AsyncSnapshot<OrderEntity> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: LoadingIndicatorWidget());
              } else if (snapshot.hasError) {
                return CustomErrorWidget(
                  useFlex: false,
                  message: '${snapshot.error}',
                  onRetry: () => setState(() {}),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
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
