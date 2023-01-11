import 'package:flutter/material.dart';

import 'error_route_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      // case IntroScreen.route:
      //   return materialPage(const IntroScreen());

      // case LoginView.route:
      //   return materialPage(const LoginView());

      // case SignUpView.route:
      //   return materialPage(const SignUpView());

      default:
        return errorRoute();
    }
  }

  static MaterialPageRoute materialPage(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
