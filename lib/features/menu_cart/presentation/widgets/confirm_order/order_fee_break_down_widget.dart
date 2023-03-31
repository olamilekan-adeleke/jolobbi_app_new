import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/utils.dart';
import '../../cubit/create_order_cubit.dart';
import '../../formz/order_formz.dart';

class OrderBreakDownWidget extends StatelessWidget {
  const OrderBreakDownWidget({super.key});

  static final CreateOrderCubit createOrderCubit =
      SetUpLocators.getIt<CreateOrderCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, OrderFormzModel>(
      bloc: createOrderCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWidget(
              "Recept Breakdown",
              fontWeight: FontWeight.w500,
              fontSize: sp(18),
            ),
            verticalSpace(5),
            _buildBreakDownWidget("Discount", 0),
            _buildBreakDownWidget("Vat", 0),
            _buildBreakDownWidget("Delivery Fee", state.deliveryFee ?? 0),
            _buildBreakDownWidget("Subtotal", state.subTotal),
            Divider(color: kcSoftTextColor.withOpacity(0.5)),
            _buildBreakDownWidget("Total", state.totalFee),
          ],
        );
      },
    );
  }

  Column _buildBreakDownWidget(String title, int amount) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextWidget(title, fontSize: sp(14), fontWeight: FontWeight.w300),
            TextWidget(
              currencyFormatter(amount),
              fontSize: sp(14),
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        verticalSpace(5),
      ],
    );
  }
}
