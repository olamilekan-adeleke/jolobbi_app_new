import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cores/constants/color.dart';
import '../cores/navigator/app_router.dart';
import '../cores/navigator/router_generator.dart';
import '../features/home/presentation/pages/home_tab_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, Widget? child) {
        return MaterialApp(
          title: 'Jolobbi',
          theme: ThemeData(
            errorColor: kcErrorColor,
            scaffoldBackgroundColor: kcBackground,
            primaryColor: kcPrimaryColor,
            useMaterial3: true,
          ),
          // initialRoute: IntroScreen.route,
          initialRoute: HomeTabScreen.route,
          onGenerateRoute: RouteGenerator.generateRoute,
          navigatorKey: AppRouter.instance.navigatorKey,
        );
      },
    );
  }
}
