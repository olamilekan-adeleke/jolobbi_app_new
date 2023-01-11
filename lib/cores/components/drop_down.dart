import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../utils/sizer_utils.dart';
import 'custom_text_widget.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    Key? key,
    required this.items,
    required this.title,
    this.value,
    this.onTap,
    this.hintText,
    this.fillColor,
  }) : super(key: key);

  final List<String> items;
  final String title;
  final String? hintText;
  final String? value;
  final Function(String val)? onTap;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          title,
          fontSize: sp(14),
          textColor: kcTextColor.withOpacity(0.5),
        ),
        verticalSpace(5),
        SizedBox(
          height: sp(55),
          child: DropdownButtonFormField<String>(
            isDense: true,
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue == null && onTap == null) return;

              onTap!(newValue!);
            },
            iconEnabledColor: kcPrimaryColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF4FFFF),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: kcGrey400),
                borderRadius: BorderRadius.circular(sp(8.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kcPrimaryColor),
                borderRadius: BorderRadius.circular(sp(8.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kcGrey400),
                borderRadius: BorderRadius.circular(sp(8.0)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kcGrey400),
                borderRadius: BorderRadius.circular(sp(8.0)),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: kcTextColor.withOpacity(0.5),
                fontWeight: FontWeight.w400,
                fontSize: sp(13),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
