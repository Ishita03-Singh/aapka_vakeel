import 'package:flutter/material.dart';
import '../Utilities/colors.dart';

class MyButtonStyle {
  static ButtonStyle appbarButton = TextButton.styleFrom(
      backgroundColor: AppColor.secondaryColor,
      fixedSize: const Size(50, 50),
      elevation: 0,
      minimumSize: const Size(50, 10),
      padding: EdgeInsets.zero);

  static ButtonStyle overlay_buttons_left = TextButton.styleFrom(
    minimumSize: const Size(double.infinity, 40),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
    side: BorderSide(color: AppColor.secondaryTextColor.withOpacity(0.3)),
    alignment: Alignment.centerLeft,
    backgroundColor: AppColor.secondaryColor,
  );
  static ButtonStyle overlay_viewButtons = TextButton.styleFrom(
    minimumSize: const Size(double.infinity, 40),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
    side: BorderSide(color: AppColor.secondaryTextColor.withOpacity(0.3)),

    alignment: Alignment.centerLeft,
    backgroundColor: AppColor.secondaryColor,

    foregroundColor: AppColor.secondaryColor,
    // minimumSize: const Size(double.infinity, 40),
    // alignment: Alignment.centerLeft,
    // backgroundColor: AppColor.bgColor,
    // elevation: 2,
    // shadowColor: AppColor.tertiaryColor
  );

  static ButtonStyle overlay_streamButton(bool selected) =>
      TextButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        side: BorderSide(
            color: selected
                ? AppColor.secondaryColor
                : AppColor.secondaryTextColor.withOpacity(0.3)),

        alignment: Alignment.centerLeft,
        backgroundColor:
            selected ? AppColor.tertiaryColor : AppColor.secondaryColor,

        // foregroundColor:
        //     selected ? AppColor.secondaryColor : AppColor.secondaryColor,
        // backgroundColor: selected ? AppColor.bgColor : AppColor.bgColor,
        // elevation: 2,
        // shadowColor:
        //     selected ? AppColor.tertiaryColor : AppColor.tertiaryColor
      );
}
