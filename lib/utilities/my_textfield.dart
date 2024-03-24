import 'package:flutter/material.dart';
import '../Utilities/colors.dart';
// import 'custom_outlined_icons_icons.dart';

class MyTextField {
  static defaultDecoration(String labeltext) => InputDecoration(
      hintText: labeltext,
      filled: true,
      fillColor: AppColor.textFieldColor,
      hintStyle: TextStyle(color: AppColor.secondaryTextColor),
      errorStyle: const TextStyle(color: Colors.red),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.secondaryColor)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryTextColor)),
      focusedErrorBorder:
          const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red)));

  // add_server.dart -> TextField Decoration(for Password Field)
  static InputDecoration passwordDecoration(
          bool passwordVisible, Function onEyeClicked) =>
      InputDecoration(
          filled: true,
          fillColor: AppColor.textFieldColor,
          // hintText: StrLiteral.formField4,
          hintStyle: TextStyle(color: AppColor.secondaryTextColor),
          errorStyle: const TextStyle(color: Colors.red),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.secondaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryTextColor)),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          suffixIcon: IconButton(
              splashRadius: 2,
              icon: Icon(
                  passwordVisible
                      ? Icons.remove_red_eye_rounded
                      : Icons.visibility_off,
                  color: AppColor.secondaryTextColor,
                  size: 22),
              onPressed: () => onEyeClicked()));

  static InputDecoration filledTextField(String labeltext, String hinttext) =>
      InputDecoration(
          hintText: hinttext,
          filled: true,
          fillColor: Color(0xffececec),
          hintStyle: TextStyle(
              color: AppColor.secondaryTextColor,
              fontSize: 13,
              fontWeight: FontWeight.w400),
          errorStyle: const TextStyle(color: Colors.red),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffececec))),
          focusedBorder: UnderlineInputBorder( 
              borderSide: BorderSide(color: Color(0xffececec))),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red)));
  // setting.dart -> TextField Decoration
  static InputDecoration settingDecoration(String labeltext, String hinttext) =>
      InputDecoration(
          hintText: hinttext,
          filled: true,
          fillColor: AppColor.secondaryColor,
          hintStyle: TextStyle(
              color: AppColor.secondaryTextColor,
              fontSize: 13,
              fontWeight: FontWeight.w400),
          errorStyle: const TextStyle(color: Colors.red),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.secondaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryTextColor)),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red)));

  static customTextFieldText() {
    return TextStyle(
        color: AppColor.primaryTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w400);
  }

  // add_server.dart -> IP address TextField Validator
  static bool ipValidate(String value) {
    List subStr = value.split(".");
    if (subStr.length == 4) {
      for (var i = 0; i < subStr.length; i++) {
        int? num = int.tryParse(subStr[i]);
        if (num == null || num > 256 || num < 0) return true;
      }
      return false;
    } else {
      return true;
    }
  }
}
