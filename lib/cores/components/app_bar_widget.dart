import 'package:flutter/material.dart';

import '../navigator/app_router.dart';
import '../utils/sizer_utils.dart';
import 'custom_text_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
    this.title, {
    Key? key,
    this.showBackButton = true,
    this.trilling,
    this.leading,
    this.useSpacer = false,
  }) : super(key: key);

  final String title;
  final bool showBackButton;
  final Widget? trilling;
  final Widget? leading;
  final bool useSpacer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (showBackButton)
          GestureDetector(
            onTap: AppRouter.instance.goBack,
            child: Padding(
              padding: EdgeInsets.only(
                right: sp(showBackButton ? 20.0 : 40),
                top: sp(20.0),
                bottom: sp(20.0),
              ),
              child: Center(child: Icon(Icons.arrow_back, size: sp(20))),
            ),
          )
        else
          leading ?? const SizedBox.shrink(),
        if (useSpacer && leading != null) const Spacer(),
        TextWidget(title, fontSize: sp(24)),
        if (useSpacer) const Spacer(),
        trilling ?? SizedBox(height: sp(20), width: sp(40)),
      ],
    );
  }
}
