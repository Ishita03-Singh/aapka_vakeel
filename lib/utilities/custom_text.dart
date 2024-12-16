// import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:flutter/material.dart';
// import '../Utilities/colors.dart';

class CustomText {
  static var DarkColor= Color(0XFF0D1B2A);
      static Text appNameText(String text, {bool isCenter = false}) {
    return Text(text,
          textAlign: isCenter ? TextAlign.center : TextAlign.left,
          style: TextStyle(
              fontSize: 22, color: DarkColor, fontWeight: FontWeight.w700));
      }



      static Text headText(String text,{Color ?color}){
        color ??= DarkColor; // Assign default value here
    return Text(text,
          style: TextStyle(
              fontSize: 24, color: color, fontWeight: FontWeight.w900));
      }


  static Text colorText(String text,{Color color=const Color.fromARGB(255, 2, 35, 62)}) => Text(text,
      style: TextStyle(
          fontSize: 18, color: color, fontWeight: FontWeight.w900));

  static Text boldinfoText(String text) => Text(text,
      style: TextStyle(
          fontSize: 18, color: Color(0xFF9C9999), fontWeight: FontWeight.w900));

  static Text RegularDarkText(String text,{double fontSize=18}) => Text(text,
      style: TextStyle(
          fontSize: fontSize, color: DarkColor, fontWeight: FontWeight.w400));

  static Text boldDarkText(String text,{double fontSize=18,bool isCenter=false}) => Text(text,
   textAlign: isCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
          fontSize: fontSize, color: DarkColor, fontWeight: FontWeight.w800));


  static Text smallheadText(String text) => Text(text,
      style: TextStyle(
          fontSize: 16, color: DarkColor, fontWeight: FontWeight.w900));

  static Text infoText(String text, {bool isCenter = false}) => Text(text,
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
          fontSize: 14,
          overflow: TextOverflow.clip,
          color: AppColor.secondaryTextColor,
          fontWeight: FontWeight.w300));


    static Text extraSmallinfoText(String text, {bool isCenter = false}) => Text(text,
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
          fontSize: 10,
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
      textAlign: TextAlign.center,
      text,
      style: TextStyle(
          fontSize: fontsize,
          color: DarkColor,
          fontWeight: FontWeight.w600));

          
  static taskBtnText(String text, {double fontsize = 16}) => Text(
      textAlign: TextAlign.center,
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
