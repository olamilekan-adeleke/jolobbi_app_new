import 'package:flutter/material.dart';

import '../constants/color.dart';

class AlertHelper {
  static void show({required BuildContext context, required Widget child}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(content: child, backgroundColor: kcWhite),
    );
  }
}
