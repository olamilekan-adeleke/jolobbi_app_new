import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../../profile/presentation/bloc/get_profile/get_profile_bloc_bloc.dart';
import '../../bloc/create_order/create_order_bloc.dart';
import '../../cubit/cart_items_cubit.dart';
import '../../cubit/create_order_cubit.dart';
import '../../formz/cart_item_formz.dart';
import '../../formz/order_formz.dart';
import '../../widgets/confirm_order/order_deliver_widget.dart';
import '../../widgets/confirm_order/order_fee_break_down_widget.dart';
import '../../widgets/confirm_order/order_item_widget.dart';
import '../../widgets/confirm_order/order_payment_type_widget.dart';

class ConfirmFoodOrderView extends StatefulWidget {
  static const String route = '/confirmFoodOrderView';

  const ConfirmFoodOrderView({super.key});

  @override
  State<ConfirmFoodOrderView> createState() => _ConfirmFoodOrderViewState();
}

class _ConfirmFoodOrderViewState extends State<ConfirmFoodOrderView> {
  final CreateOrderCubit createOrderCubit =
      SetUpLocators.getIt<CreateOrderCubit>();
  final CartItemCubit cartItemCubit = SetUpLocators.getIt<CartItemCubit>();

  final CreateOrderBloc createOrderBloc =
      SetUpLocators.getIt<CreateOrderBloc>();
  final GetProfileBloc getProfileBloc = SetUpLocators.getIt<GetProfileBloc>();

  @override
  void initState() {
    createOrderCubit.reset();

    // setData
    createOrderCubit.addUserDetails(getProfileBloc.userDetailsEntity);

    List<CartItemFormz> cartItems = cartItemCubit.state.cartItems;
    createOrderCubit.addOrderItem(cartItems);

    createOrderCubit.addServiceFee(50);
    createOrderCubit.addDeliveryFee(200);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateOrderBloc, CreateOrderState>(
      bloc: createOrderBloc,
      listener: createOrderListener,
      child: ScaffoldWidget(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const AppBarWidget("Order Confirmation", useSpacer: true),
            const OrderItemWidget(),
            verticalSpace(20),
            const OrderDeliverWidget(),
            verticalSpace(20),
            const OrderBreakDownWidget(),
            verticalSpace(20),
            const OrderPaymentTypeWidget(),
            verticalSpace(40),
            BlocBuilder<CreateOrderBloc, CreateOrderState>(
              bloc: createOrderBloc,
              builder: (context, state) {
                if (state is CreateOrderLoading) {
                  return const Button.loading();
                }

                return buildButton();
              },
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    return BlocBuilder<CreateOrderCubit, OrderFormzModel>(
      bloc: createOrderCubit,
      builder: (context, state) {
        return Button(
          active: state.isValid,
          text: "Place Order",
          onTap: () => createOrderBloc.add(
            CreateOrderEvent(createOrderCubit.state),
          ),
        );
      },
    );
  }
}

extension on _ConfirmFoodOrderViewState {
  void createOrderListener(BuildContext context, CreateOrderState state) {
    if (state is CreateOrderError) {
      SnackBarService.showErrorSnackBar(
        context: context,
        message: state.message,
      );
    } else if (state is CreateOrderSuccess) {
      SnackBarService.showSuccessSnackBar(
        context: context,
        message: state.baseEntity.message,
      );

      // createOrderCubit.reset();
      // cartItemCubit.clearCart();
      // AppRouter.instance.goBack();
      // AppRouter.instance.goBack();
    }
  }
}
