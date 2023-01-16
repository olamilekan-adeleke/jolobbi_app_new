import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';

class HomeView extends StatelessWidget {
  static const String route = "/home";

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: const [
          Center(child: Text("Home")),
        ],
      ),
    );
  }
}
