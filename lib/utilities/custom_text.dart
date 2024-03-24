import 'package:flutter/material.dart';
import '../Utilities/colors.dart';

class CustomText {
  static Text appNameText(String text) => Text(text,
      style: TextStyle(
          fontSize: 22, color: Colors.black, fontWeight: FontWeight.w700));
  static Text headText(String text) => Text(text,
      style: TextStyle(
          fontSize: 24, color: Colors.black, fontWeight: FontWeight.w900));

  static Text infoText(String text) => Text(text,
      style: TextStyle(
          fontSize: 14,
          color: AppColor.secondaryTextColor,
          fontWeight: FontWeight.w300));
  // static Text text(String text, {double fontsize = 16}) => Text(
  //     textAlign: TextAlign.left,
  //     text,
  //     style: TextStyle(fontSize: fontsize, color: AppColor.primaryTextColor));

  // static Text textFieldHeadText(String text, {double fontsize = 13}) => Text(
  //     textAlign: TextAlign.left,
  //     text,
  //     style: TextStyle(
  //         fontSize: fontsize,
  //         color: AppColor.primaryTextColor,
  //         fontWeight: FontWeight.w400));

  static cancelBtnText(String text, {double fontsize = 16}) => Text(
      textAlign: TextAlign.left,
      text,
      style: TextStyle(
          fontSize: fontsize,
          color: AppColor.tertiaryTextColor,
          fontWeight: FontWeight.w600));
  static taskBtnText(String text, {double fontsize = 16}) => Text(
      textAlign: TextAlign.left,
      text,
      style: TextStyle(
          fontSize: fontsize,
          color: AppColor.tertiaryTextColor,
          fontWeight: FontWeight.w600));

  // static Text text16primary(String text) => Text(text,
  //     style: TextStyle(
  //         fontSize: 14,
  //         color: AppColor.secondaryTextColor,
  //         fontWeight: FontWeight.w400));

  // static Text text12hintColor(String text,
  //         {TextAlign textAlign = TextAlign.left}) =>
  //     Text(text,
  //         textAlign: textAlign,
  //         style: TextStyle(
  //             fontSize: 14,
  //             color: AppColor.secondaryTextColor,
  //             fontWeight: FontWeight.w400));

  // static Text serverName(String text, {double fontsize = 14}) => Text(text,
  //     maxLines: 1,
  //     overflow: TextOverflow.ellipsis,
  //     style: TextStyle(
  //         fontSize: fontsize,
  //         color: AppColor.primaryTextColor,
  //         fontWeight: FontWeight.w500));

  // static Text bottomSheetText(String text, {double fontsize = 14}) => Text(
  //     textAlign: TextAlign.left,
  //     text,
  //     style: TextStyle(
  //         fontSize: fontsize,
  //         color: AppColor.iconColor,
  //         fontWeight: FontWeight.w500));

  // static Text text16Secondary(String text,
  //         {TextAlign textAlign = TextAlign.left}) =>
  //     Text(text,
  //         textAlign: textAlign,
  //         style: TextStyle(
  //             fontSize: 16,
  //             color: AppColor.secondaryTextColor,
  //             fontWeight: FontWeight.w400));

  // //full_screen_video.dart
  // static Text topVideoDateTimePosition(String text) => Text(text,
  //     style: TextStyle(color: AppColor.primaryTextColor, fontSize: 20));
  // static Text bottomVideoPosition(String text) => Text(text,
  //     style: TextStyle(color: AppColor.primaryTextColor),
  //     textAlign: TextAlign.right);
  // static Text bottomVideoTotalDuration(String text) => Text(text,
  //     style: TextStyle(color: AppColor.primaryTextColor),
  //     textAlign: TextAlign.left);
}
