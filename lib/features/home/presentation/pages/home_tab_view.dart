import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jolobbi_app_new/cores/components/components.dart';

import '../../../../cores/constants/color.dart';

class HomeTabScreen extends StatefulWidget {
  static const String route = '/home-tab';
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  void _onTap(int index) => _currentIndex.value = index;
  static final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  static List<BottomNavigationBarItem> navBarItem = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      activeIcon: Icon(CupertinoIcons.home, color: kcPrimaryColor),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.fastfood_outlined),
      activeIcon: Icon(Icons.fastfood_outlined, color: kcPrimaryColor),
      label: 'Food',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_basket_outlined),
      activeIcon: Icon(Icons.shopping_basket_outlined, color: kcPrimaryColor),
      label: 'Grocery',
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

  static List<Widget> pages = const <Widget>[
    SizedBox(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
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
