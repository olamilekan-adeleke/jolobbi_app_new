import 'package:flutter/material.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/utils.dart';

class OrderPaymentTypeWidget extends StatelessWidget {
  const OrderPaymentTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          icon: Icons.wallet_rounded,
          title: "Pay With Wallet",
        ),
        _buildOptionWidget(
          icon: Icons.monetization_on,
          title: "Cash On Delivery (Coming Soon)",
          isActive: false,
        ),
      ],
    );
  }

  Widget _buildOptionWidget({
    required IconData icon,
    required String title,
    bool isActive = true,
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
            color: kcSoftTextColor.withOpacity(isActive ? 0.5 : 0.3),
          ),
          horizontalSpace(),
          TextWidget(
            title,
            fontSize: sp(16),
            fontWeight: FontWeight.w500,
            textColor: isActive ? null : kcSoftTextColor.withOpacity(0.5),
          )
        ],
      ),
      groupValue: true,
      onChanged: (value) {},
      activeColor: kcPrimaryColor,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
    );
  }
}
