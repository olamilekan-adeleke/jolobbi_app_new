import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/components/custom_textfiled.dart';
import '../../../../cores/constants/constants.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const AbsorbPointer(
        absorbing: true,
        child: TextFieldWidget(
          hintText: "Search For Food",
          prefixWidget: SizedBox(
            child: Icon(Icons.search, color: kcSoftTextColor),
          ),
        ),
      ),
    );
  }
}
