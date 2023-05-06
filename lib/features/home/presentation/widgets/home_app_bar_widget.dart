import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../cores/components/components.dart';

import '../../../../cores/utils/utils.dart';

class HomeAppBarWidget extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const HomeAppBarWidget({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // GestureDetector(
        //   onTap: onMenuPressed,
        //   child: const Icon(CupertinoIcons.list_dash),
        // ),
        horizontalSpace(33),
        const Spacer(),
        TextWidget("Jolobbi Food", fontSize: sp(24)),
        const Spacer(),
        // Row(
        //   children: [
        //     GestureDetector(
        //       onTap: () {},
        //       child: const Icon(CupertinoIcons.bell),
        //     ),
        //     horizontalSpace(),
        //     GestureDetector(
        //       onTap: () {},
        //       child: const Icon(Icons.location_on_outlined),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
