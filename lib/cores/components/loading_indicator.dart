import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({
    Key? key,
    this.strokeWidth,
    this.value,
  }) : super(key: key);

  final double? strokeWidth;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      // color: Colors.grey[200],
      backgroundColor: Colors.grey,
      strokeWidth: strokeWidth ?? 2.0,
      value: value,
    );
  }
}
