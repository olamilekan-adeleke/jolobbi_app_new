import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/utils.dart';
import '../widgets/login_widgets/login_form_widget.dart';

class LoginView extends StatelessWidget {
  static const String route = "/login";

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      usePadding: false,
      useSingleScroll: false,
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: kcPrimaryColor),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kcWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(sp(10)),
                  topRight: Radius.circular(sp(10)),
                ),
              ),
              child: const LoginFormWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
