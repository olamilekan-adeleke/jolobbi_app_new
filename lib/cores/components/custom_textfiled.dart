import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cores/constants/color.dart';
import '../../cores/utils/sizer_utils.dart';
import 'custom_text_widget.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    this.textEditingController,
    this.autoCorrect = true,
    required this.hintText,
    this.title,
    this.validator,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.enabled = true,
    this.maxLine = 1,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.boldHintText = false,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final bool autoCorrect;
  final String hintText;
  final String? title;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType textInputType;
  final bool isPassword;
  final bool enabled;
  final bool boldHintText;
  final int? maxLine;
  final IconData? suffix;
  final IconData? prefix;

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureText,
      builder: (BuildContext context, bool value, dynamic child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextWidget(
            //   widget.title,
            //   fontSize: sp(14),
            //   fontWeight: FontWeight.w500,
            //   textColor: kcTextColor.withOpacity(0.5),
            // ),
            // verticalSpace(5),
            TextFormField(
              maxLines: widget.maxLine,
              enabled: widget.enabled,
              cursorColor: kcPrimaryColor,
              style: TextStyle(
                color: kcTextColor,
                fontWeight: FontWeight.w400,
                fontSize: sp(13),
              ),
              controller: widget.textEditingController,
              autocorrect: widget.autoCorrect,
              autovalidateMode: widget.validator != null
                  ? AutovalidateMode.onUserInteraction
                  : null,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffF4FFFF),
                // fillColor: const Color(0xffF4FFFF).withOpacity(0.2),
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
                  borderSide: const BorderSide(color: kcPrimaryColor),
                  borderRadius: BorderRadius.circular(sp(8.0)),
                ),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: kcTextColor.withOpacity(0.5),
                  fontWeight: FontWeight.w300,
                  fontSize: sp(13),
                ),
                // prefix: widget.prefix != null
                //     ? Icon(widget.prefix, color: kcTextColor)
                //     : const SizedBox.shrink(),
                suffixIcon: widget.isPassword == true
                    ? suffixWidget(value)
                    : widget.suffix != null
                        ? Icon(widget.suffix)
                        : const SizedBox(),
              ),
              keyboardType: widget.textInputType,
              obscureText: value && widget.isPassword,
              validator: (String? val) {
                if (val == null || widget.validator == null) return null;

                return widget.validator!(val.trim());
              },
              onChanged: (String val) {
                if (widget.onChanged == null) return;

                widget.onChanged!(val.trim());
              },
            ),
          ],
        );
      },
    );
  }

  IconButton suffixWidget(bool value) {
    if (value) {
      return IconButton(
        icon: const Icon(CupertinoIcons.eye_slash_fill),
        color: kcGrey400,
        onPressed: () => obscureText.value = !obscureText.value,
      );
    } else {
      return IconButton(
        icon: const Icon(CupertinoIcons.eye_fill),
        color: kcPrimaryColor,
        onPressed: () => obscureText.value = !obscureText.value,
      );
    }
  }
}
