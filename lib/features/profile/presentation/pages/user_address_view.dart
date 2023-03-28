import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/sizer_utils.dart';

class UserAddressView extends StatelessWidget {
  static const String route = '/userAddressView';

  const UserAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: <Widget>[
          const AppBarWidget("User Address", useSpacer: true),
          verticalSpace(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kcPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
