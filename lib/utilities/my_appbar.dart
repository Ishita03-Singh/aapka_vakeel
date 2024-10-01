import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:flutter/material.dart';

class MyAppBar {
  static appbar(context,{String head= StrLiteral.appName,}) {
    return AppBar(
      titleSpacing: 16,
      title: Align(
          alignment: Alignment.centerLeft,
          child: CustomText.appNameText(head)),
      backgroundColor: AppColor.bgColor,
      actions: [
        customButton.iconButton(
            context, "Help", Icons.help_outline_rounded, () {})
      ],
    );
  }
}
