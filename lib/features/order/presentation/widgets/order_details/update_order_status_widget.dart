import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/navigator/navigator.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecases/cancel_order_usecase.dart';
import '../../../domain/usecases/update_order_usecase.dart';
import '../../bloc/cancel_order/cancel_order_bloc.dart';
import '../../bloc/get_all_orders/get_all_orders_bloc.dart';
import '../../bloc/update_order/update_order_bloc.dart';

class UpdateOrderStatusWidget extends StatelessWidget {
  final OrderEntity order;
  const UpdateOrderStatusWidget(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Button(
          text: "Update Status",
          onTap: () => BottomSheetHelper.show(
           context,
            child: UpdateOrderStatusOptionWidget(order),
          ),
        ),
        verticalSpace(15),
        Button(
          text: "Cancel Order",
          color: kcErrorColor,
          onTap: () => AlertHelper.show(
            context: context,
            child: CancelOrderStatusOptionWidget(order),
          ),
        ),
        verticalSpace(20),
      ],
    );
  }
}

class UpdateOrderStatusOptionWidget extends StatelessWidget {
  final OrderEntity order;
  const UpdateOrderStatusOptionWidget(this.order, {super.key});

  static final UpdateOrderBloc _bloc = SetUpLocators.getIt<UpdateOrderBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateOrderBloc, UpdateOrderState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is UpdateOrderSuccess) {
          SnackBarService.showSuccessSnackBar(
            context: context,
            message: state.entity.message,
          );

          SetUpLocators.getIt<GetAllOrdersBloc>()
              .add(const GetAllOrdersEvent());
          AppRouter.instance.goBack();
        } else if (state is UpdateOrderError) {
          SnackBarService.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
      },
      child: Column(
        children: <Widget>[
          verticalSpace(20),
          TextWidget(
            "You Are About To Update Order Status",
            fontWeight: FontWeight.w600,
            fontSize: sp(18),
          ),
          verticalSpace(20),
          Icon(Icons.error, color: kcSoftTextColor.withOpacity(0.5), size: 50),
          verticalSpace(20),
          TextWidget(
            "Order status will be updated form ${order.status.name.toUpperCase()} to ${order.getNextOrderStatus.name.toUpperCase()}",
            fontWeight: FontWeight.w300,
            fontSize: sp(15),
            textAlign: TextAlign.center,
          ),
          verticalSpace(20),
          BlocBuilder<UpdateOrderBloc, UpdateOrderState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is UpdateOrderLoading) return const Button.loading();

              return Button(
                text: "Update Status To ${order.getNextOrderStatus.name}",
                onTap: () {
                  _bloc.add(UpdateOrderEvent(UpdateOrderStatusParams(
                    id: order.orderId,
                    status: order.getNextOrderStatus,
                  )));
                },
              );
            },
          ),
          verticalSpace(40),
        ],
      ),
    );
  }
}

class CancelOrderStatusOptionWidget extends StatelessWidget {
  final OrderEntity order;
  const CancelOrderStatusOptionWidget(this.order, {super.key});

  static final CancelOrderBloc _bloc = SetUpLocators.getIt<CancelOrderBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CancelOrderBloc, CancelOrderState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is CancelOrderSuccess) {
          SnackBarService.showSuccessSnackBar(
            context: context,
            message: state.entity.message,
          );

          SetUpLocators.getIt<GetAllOrdersBloc>()
              .add(const GetAllOrdersEvent());
          AppRouter.instance.goBack();
        } else if (state is CancelOrderError) {
          SnackBarService.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          verticalSpace(20),
          TextWidget(
            "You Are About To Cancel This Order",
            fontWeight: FontWeight.w600,
            fontSize: sp(18),
          ),
          TextWidget(
            "Are you sure you want to cancel this order?",
            fontWeight: FontWeight.w300,
            fontSize: sp(15),
            textAlign: TextAlign.center,
          ),
          verticalSpace(20),
          const Icon(Icons.error, color: kcErrorColor, size: 50),
          verticalSpace(20),
          TextWidget(
            "Once you cancel this order, you will not be able to recover it"
            " and the order fee will be refunded to the customer back. "
            "\nAre you sure you want to cancel this order?",
            fontWeight: FontWeight.w300,
            fontSize: sp(15),
            textAlign: TextAlign.center,
          ),
          verticalSpace(20),
          BlocBuilder<CancelOrderBloc, CancelOrderState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is CancelOrderLoading) return const Button.loading();

              return Row(
                children: [
                  Flexible(
                    child: Button(
                      color: kcSoftTextColor.withOpacity(0.5),
                      text: "Nope",
                      onTap: () => AppRouter.instance.goBack(),
                    ),
                  ),
                  horizontalSpace(),
                  Flexible(
                    child: Button(
                      text: "Cancel Order",
                      color: kcErrorColor,
                      onTap: () {
                        _bloc.add(CancelOrderEvent(CancelOrderStatusParams(
                          id: order.orderId,
                          reason: "order.getNextOrderStatus",
                        )));
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
