import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../../order/data/models/order_model.dart';
import '../../cubit/create_order_cubit.dart';
import '../../formz/order_formz.dart';

class OrderPaymentTypeWidget extends StatelessWidget {
  const OrderPaymentTypeWidget({super.key});

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
              "Select Payment Method",
              fontSize: sp(18),
              fontWeight: FontWeight.w500,
            ),
            verticalSpace(15),
            _buildOptionWidget(
              icon: Icons.account_balance_outlined,
              title: "Pay With Bank Transfer",
              isActive: state.paymentMethod == OrderPaymentMethod.bankTransfer,
              onChanged: (value) => createOrderCubit.paymentMethod(
                OrderPaymentMethod.bankTransfer,
              ),
            ),
            _buildOptionWidget(
              icon: Icons.wallet_rounded,
              title: "Pay With Wallet",
              isActive: state.paymentMethod == OrderPaymentMethod.wallet,
              onChanged: (value) => createOrderCubit.paymentMethod(
                OrderPaymentMethod.wallet,
              ),
            ),
            _buildOptionWidget(
              icon: Icons.monetization_on,
              title: "Cash On Delivery (Coming Soon)",
              isActive: state.paymentMethod == OrderPaymentMethod.cash,
              isDisable: true,
              onChanged: (value) => createOrderCubit.paymentMethod(
                OrderPaymentMethod.cash,
              ),
            ),
            BlocBuilder<CreateOrderCubit, OrderFormzModel>(
              bloc: createOrderCubit,
              builder: (context, state) {
                if (state.paymentMethod == OrderPaymentMethod.bankTransfer) {
                  return const OrderPaymentBankTransferDetailsWidget();
                }
                return Container();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildOptionWidget({
    required IconData icon,
    required String title,
    bool isActive = true,
    bool isDisable = false,
    Function(bool?)? onChanged,
  }) {
    return RadioListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.trailing,
      value: isActive,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: sp(20),
            color: kcSoftTextColor.withOpacity(isDisable ? 0.3 : 0.5),
          ),
          horizontalSpace(),
          TextWidget(
            title,
            fontSize: sp(16),
            fontWeight: FontWeight.w500,
            textColor: isDisable ? kcSoftTextColor.withOpacity(0.5) : null,
          )
        ],
      ),
      groupValue: true,
      onChanged: (val) {
        if (isDisable) return;
        onChanged?.call(val);
      },
      activeColor: kcPrimaryColor,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
    );
  }
}

class OrderPaymentBankTransferDetailsWidget extends StatelessWidget {
  const OrderPaymentBankTransferDetailsWidget({super.key});

  static final CreateOrderCubit createOrderCubit =
      SetUpLocators.getIt<CreateOrderCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        verticalSpace(),
        TextWidget(
          "Enter Bank Details",
          fontSize: sp(18),
          fontWeight: FontWeight.w500,
        ),
        TextWidget(
          "Please enter your bank account details so we can confirm your payment",
          fontSize: sp(16),
          fontWeight: FontWeight.w300,
          textAlign: TextAlign.left,
          textColor: kcSoftTextColor,
        ),
        verticalSpace(15),
        TextFieldWidget(
          title: "Account Name",
          hintText: "E.g Test User",
          onChanged: createOrderCubit.addAccountName,
        ),
        verticalSpace(),
        TextFieldWidget(
          title: "Bank Name",
          hintText: "E.g Zenith Bank",
          onChanged: createOrderCubit.addBankName,
        ),
      ],
    );
  }
}
