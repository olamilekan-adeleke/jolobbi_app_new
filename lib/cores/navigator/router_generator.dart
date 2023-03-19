import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/Authentication/presentation/pages/auth_state_view.dart';
import '../../features/Authentication/presentation/pages/forgot_password_view.dart';
import '../../features/Authentication/presentation/pages/intro_view.dart';
import '../../features/Authentication/presentation/pages/login_view.dart';
import '../../features/Authentication/presentation/pages/sign_up_view.dart';
import '../../features/home/domain/entities/shop_details_entity.dart';
import '../../features/home/presentation/pages/all_fast_food_view.dart';
import '../../features/home/presentation/pages/home_tab_view.dart';
import '../../features/home/presentation/pages/home_view.dart';
import '../../features/home/presentation/pages/search_food_view.dart';
import '../../features/home/presentation/pages/search_restaurant_view.dart';
import '../../features/menu_cart/presentation/pages/confirm_food_order_view.dart';
import '../../features/vendor/presentation/pages/menu_item_details_view.dart';
import '../../features/vendor/presentation/pages/vendor_details_view.dart';
import 'error_route_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final Object? args = settings.arguments;

    switch (settings.name) {
      case AuthStateView.route:
        return pageRoute(const AuthStateView());

      case IntroScreen.route:
        return pageRoute(const IntroScreen());

      case LoginView.route:
        return pageRoute(const LoginView());

      case SignUpView.route:
        return pageRoute(const SignUpView());

      case ForgotPasswordView.route:
        return pageRoute(const ForgotPasswordView());

      case HomeTabScreen.route:
        return pageRoute(const HomeTabScreen());

      case HomeView.route:
        return pageRoute(const HomeView());

      case VendorDetailsView.route:
        final ShopDetailsEntity shop = settings.arguments as ShopDetailsEntity;
        return pageRoute(VendorDetailsView(shop));

      case MenuItemDetailsView.route:
        return pageRoute(const MenuItemDetailsView());

      case ConfirmFoodOrderView.route:
        return pageRoute(const ConfirmFoodOrderView());

      case SearchFoodMenuView.route:
        return pageRoute(const SearchFoodMenuView());

      case AllFastFoodView.route:
        return pageRoute(const AllFastFoodView());

      case SearchRestaurantView.route:
        return pageRoute(const SearchRestaurantView());

      default:
        return errorRoute();
    }
  }

  static PageRoute pageRoute(Widget page) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(builder: (_) => page);
    }

    return MaterialPageRoute(builder: (_) => page);
  }
}
