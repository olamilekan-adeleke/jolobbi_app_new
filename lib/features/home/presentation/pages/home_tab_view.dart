import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/constants/color.dart';
import '../../../menu_cart/presentation/pages/cart_view.dart';
import '../../../menu_cart/presentation/widgets/cart_icon_widget.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../../../wallet/presentation/pages/wallet_view.dart';
import 'home_view.dart';

class HomeTabScreen extends StatefulWidget {
  static const String route = '/home-tab';
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  void _onTap(int index) => _currentIndex.value = index;
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  List<BottomNavigationBarItem> navBarItem = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.fastfood_outlined),
      activeIcon: Icon(Icons.fastfood_outlined, color: kcPrimaryColor),
      label: 'Food',
    ),
    const BottomNavigationBarItem(
      icon: IgnorePointer(child: CartIconWidget()),
      activeIcon: IgnorePointer(child: CartIconWidget(color: kcPrimaryColor)),
      label: 'Cart',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.wallet),
      activeIcon: Icon(Icons.wallet, color: kcPrimaryColor),
      label: 'Wallet',
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      activeIcon: Icon(CupertinoIcons.person, color: kcPrimaryColor),
      label: 'Profile',
    ),
  ];

  List<Widget> pages = const <Widget>[
    HomeView(),
    MenuCartView(),
    WalletView(),
    ProfileView(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _currentIndex,
      builder: (_, int index, __) {
        return ScaffoldWidget(
          usePadding: false,
          useSingleScroll: false,
          body: IndexedStack(
            index: index,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: _onTap,
            items: navBarItem,
            selectedItemColor: kcPrimaryColor,
            unselectedItemColor: kcGrey400,
          ),
        );
      },
    );
  }
}
