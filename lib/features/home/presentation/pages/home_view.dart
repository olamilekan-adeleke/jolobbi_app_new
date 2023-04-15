import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../widgets/home_app_bar_widget.dart';
import '../widgets/home_fast_food_list_widget.dart';
import '../widgets/home_near_by_fast_food_widget.dart';
import '../widgets/home_search_widget.dart';

class HomeView extends StatelessWidget {
  static const String route = "/home";

  const HomeView({super.key});

  static final SidebarXController sidebarXController = SidebarXController(
    selectedIndex: 0,
    extended: true,
  );

  static final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      // scaffoldKey: _key,
      // drawer: NavDrawer(),
      // appBar: AppBar(title: const Text('Side menu')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(),
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const IgnorePointer(
              ignoring: true,
              child: HomeAppBarWidget(),
            ),
          ),
          verticalSpace(20),
          const HomeSearchWidget(),
          verticalSpace(20),
          const HomeNearByFastFoodWidget(),
          verticalSpace(20),
          const HomeFastFoodListWidget(),
        ],
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: TextWidget(
              'Side menu',
              // style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const TextWidget('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const TextWidget('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const TextWidget('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const TextWidget('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const TextWidget('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
