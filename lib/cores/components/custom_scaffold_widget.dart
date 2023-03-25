import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/color.dart';
import '../constants/font_size.dart';
import '../utils/sizer_utils.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    Key? key,
    required this.body,
    this.appBar,
    this.usePadding = true,
    this.useSingleScroll = true,
    this.bg,
    this.scaffoldKey,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
  }) : super(key: key);

  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget body;
  final AppBar? appBar;
  final bool usePadding;
  final bool useSingleScroll;
  final Color? bg;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.black,
      ),
    );

    return Scaffold(
      drawerEnableOpenDragGesture: true,
      key: scaffoldKey,
      appBar: appBar,
      backgroundColor: bg ?? kcBackground,
      body: SafeArea(
        child: SizedBox(
          height: sh(98),
          child: useSingleScroll
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: usePadding ? sp(kGlobalPadding) : 0,
                    ),
                    child: body,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: usePadding ? sp(kGlobalPadding) : 0,
                  ),
                  child: body,
                ),
        ),
      ),
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
