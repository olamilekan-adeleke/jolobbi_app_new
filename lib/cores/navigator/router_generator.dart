import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/Authentication/presentation/pages/auth_state_view.dart';
import '../../features/Authentication/presentation/pages/forgot_password_view.dart';
import '../../features/Authentication/presentation/pages/intro_view.dart';
import '../../features/Authentication/presentation/pages/login_view.dart';
import '../../features/Authentication/presentation/pages/sign_up_view.dart';
import '../../features/home/domain/entities/menu_item_entity.dart';
import '../../features/home/domain/entities/shop_details_entity.dart';
import '../../features/home/presentation/pages/all_fast_food_view.dart';
import '../../features/home/presentation/pages/home_tab_view.dart';
import '../../features/home/presentation/pages/home_view.dart';
import '../../features/home/presentation/pages/search_food_view.dart';
import '../../features/home/presentation/pages/search_restaurant_view.dart';
import '../../features/menu_cart/presentation/pages/cart_view.dart';
import '../../features/menu_cart/presentation/pages/order/confirm_food_order_view.dart';
import '../../features/order/domain/entities/order_entity.dart';
import '../../features/order/presentation/pages/order_details_view.dart';
import '../../features/order/presentation/pages/order_views.dart';
import '../../features/profile/presentation/pages/address/add_address_view.dart';
import '../../features/profile/presentation/pages/address/user_address_view.dart';
import '../../features/vendor/presentation/pages/menu_item_details_view.dart';
import '../../features/vendor/presentation/pages/vendor_details_view.dart';
import '../../features/wallet/presentation/pages/payment_gateway_screen/flutter_wave_payment_view.dart';
import '../../features/wallet/presentation/pages/payment_gateway_screen/paystack_payment_view.dart';
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
        final MenuItemEntity menuItem = settings.arguments as MenuItemEntity;
        return pageRoute(MenuItemDetailsView(menuItem));

      case MenuCartView.route:
        return pageRoute(const MenuCartView());

      case ConfirmFoodOrderView.route:
        return pageRoute(const ConfirmFoodOrderView());

      case SearchFoodMenuView.route:
        return pageRoute(const SearchFoodMenuView());

      case AllFastFoodView.route:
        return pageRoute(const AllFastFoodView());

      case SearchRestaurantView.route:
        return pageRoute(const SearchRestaurantView());

      case FlutterWavePaymentView.routeName:
        final FlutterWavePaymentArgs args =
            settings.arguments as FlutterWavePaymentArgs;
        return pageRoute(FlutterWavePaymentView(args));

      case PaystackPaymentView.routeName:
        final FlutterWavePaymentArgs args =
            settings.arguments as FlutterWavePaymentArgs;
        return pageRoute(PaystackPaymentView(args));

      case UserAddressView.route:
        return pageRoute(const UserAddressView());

      case AddAddressView.route:
        return pageRoute(const AddAddressView());

      case OrderView.routeName:
        return pageRoute(const OrderView());

      case OrderDetailsView.routeName:
        final OrderEntity args = settings.arguments as OrderEntity;
        return pageRoute(OrderDetailsView(args));

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
