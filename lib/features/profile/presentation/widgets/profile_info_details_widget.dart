import 'package:flutter/material.dart';
import '../../../order/presentation/pages/order_views.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/navigator/navigator.dart';
import '../../../../cores/utils/utils.dart';
import '../../../Authentication/presentation/pages/login_view.dart';
import '../../domain/entities/user_details_entity.dart';

class ProfileInfoDetailsWidget extends StatelessWidget {
  final UserDetailsEntity userDetailsEntity;

  const ProfileInfoDetailsWidget(this.userDetailsEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(sr(50)),
          child: ImageWidget(
            height: h(70),
            width: w(70),
            imageTypes: ImageTypes.profile,
            imageUrl: userDetailsEntity.displayPicture,
          ),
        ),
        verticalSpace(),
        _UserProfileDetailsWidget(userDetailsEntity),
        verticalSpace(20),
        shadowBox(
          child: Column(
            children: <Widget>[
              horizontalSpace(double.infinity),
              actionItemsWidget(
                Icons.format_list_bulleted_outlined,
                "Order History",
                onTap: () => AppRouter.instance.navigateTo(OrderView.routeName),
              ),
              verticalSpace(20),
              actionItemsWidget(Icons.person, "Edit Profile", onTap: () {}),
              verticalSpace(20),
              actionItemsWidget(Icons.lock, "Change Password", onTap: () {}),
              verticalSpace(20),
              actionItemsWidget(Icons.help, "Help", onTap: () {}),
              verticalSpace(20),
              actionItemsWidget(
                Icons.headphones,
                "Contact Support",
                onTap: () {},
              ),
              verticalSpace(40),
              actionItemsWidget(
                Icons.exit_to_app,
                "Log Out",
                onTap: () => AppRouter.instance.clearRouteAndPush(
                  LoginView.route,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(40),
        TextWidget("v 1.0.2", fontSize: sp(16), textColor: kcSoftTextColor),
      ],
    );
  }

  Widget actionItemsWidget(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Container(
            height: h(30),
            width: h(30),
            decoration: BoxDecoration(
              color: kcPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(sr(5)),
            ),
            child: Icon(icon, color: kcPrimaryColor, size: sp(15)),
          ),
          horizontalSpace(),
          TextWidget(
            title,
            fontSize: sp(14),
            fontWeight: FontWeight.w600,
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: kcSoftTextColor,
            size: sp(15),
          ),
        ],
      ),
    );
  }
}

class _UserProfileDetailsWidget extends StatelessWidget {
  final UserDetailsEntity userDetailsEntity;

  const _UserProfileDetailsWidget(this.userDetailsEntity);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextWidget(
          userDetailsEntity.fullName,
          fontSize: sp(20),
          fontWeight: FontWeight.w600,
        ),
        verticalSpace(3),
        TextWidget(
          "Tap to edit profile",
          fontSize: sp(14),
          textColor: kcPrimaryColor.withOpacity(0.8),
          decoration: TextDecoration.underline,
        ),
        verticalSpace(30),
        shadowBox(
          child: Column(
            children: <Widget>[
              horizontalSpace(double.infinity),
              itemsWidget("Email", userDetailsEntity.email),
              Divider(color: kcSoftTextColor.withOpacity(0.4)),
              itemsWidget(
                "Phone Number",
                userDetailsEntity.phoneNumber,
              ),
              Divider(color: kcSoftTextColor.withOpacity(0.4)),
              itemsWidget("Username", userDetailsEntity.username),
            ],
          ),
        ),
      ],
    );
  }

  Widget itemsWidget(String title, String value) {
    return Row(
      children: <Widget>[
        TextWidget(
          title,
          fontSize: sp(14),
          fontWeight: FontWeight.w600,
        ),
        const Spacer(),
        TextWidget(
          value,
          fontSize: sp(14),
          fontWeight: FontWeight.w600,
          textColor: kcSoftTextColor.withOpacity(0.8),
        ),
      ],
    );
  }
}

Container shadowBox({required Widget child}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    decoration: BoxDecoration(
      color: kcWhite,
      borderRadius: BorderRadius.circular(sr(10)),
      boxShadow: [
        BoxShadow(
          color: kcDarkBackground.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: child,
  );
}
