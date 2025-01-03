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

  static InputDecoration filledTextFieldCountryCode(
          String hinttext) =>
      InputDecoration(
          contentPadding: EdgeInsets.only(left: 8),
          hintText: hinttext,
          filled: true,
          fillColor: Color(0xffE0E1DD),
          hintStyle:
              TextStyle(
                  color: AppColor.secondaryTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
          errorStyle: const TextStyle(color: Colors.red),
          enabledBorder:
              UnderlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .only(
                              topRight: Radius.circular(0),
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                  borderSide: BorderSide(color: Color(0xffE0E1DD))),
          focusedBorder:
              UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE0E1DD))),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red)));

  static InputDecoration PhoneText(String hinttext) => InputDecoration(
      hintText: hinttext,
      contentPadding: EdgeInsets.only(right: 8),
      filled: true,
      fillColor: Color(0xffE0E1DD),
      hintStyle: TextStyle(
          color: AppColor.secondaryTextColor,
          fontSize: 13,
          fontWeight: FontWeight.w400),
      errorStyle: const TextStyle(color: Colors.red),
      enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xffE0E1DD))),
      focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xffE0E1DD))),
      focusedErrorBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red)),
      errorBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red)));

  static InputDecoration outlinedTextField(String hinttext) => 
  InputDecoration(
      hintText: hinttext,
      filled: false,
      // fillColor: Color(0xffececec),
      hintStyle: TextStyle(
          color: AppColor.secondaryTextColor,
          fontSize: 13,
          fontWeight: FontWeight.w400),
      errorStyle: const TextStyle(color: Colors.red),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xFFd0d0d0))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xFF0d0d0d0))),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red)),
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red)));

  static InputDecoration filledTextField(String hinttext) => InputDecoration(
      hintText: hinttext,
      filled: true,
      fillColor: Color(0xffE0E1DD),
      hintStyle: TextStyle(
          color: AppColor.secondaryTextColor,
          fontSize: 13,
          fontWeight: FontWeight.w400),
      errorStyle: const TextStyle(color: Colors.red),
      enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xffE0E1DD))),
      focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xffE0E1DD))),
      focusedErrorBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red)),
      errorBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
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
