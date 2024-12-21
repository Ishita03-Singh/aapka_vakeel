import 'package:flutter/material.dart';
import 'colors.dart';
import 'custom_text.dart';
import 'strings.dart';

class CustomMessenger {
  static defaultMessenger(BuildContext context, String text ) =>
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          content:
              Text(text, style: TextStyle(color: AppColor.primaryTextColor)),
          backgroundColor: Color(0xffececec),
          margin: const EdgeInsets.all(0),
          dismissDirection: DismissDirection.down,
          behavior: SnackBarBehavior.floating,
          // action: SnackBarAction(label: 'a', onPressed: () {}),
          duration: const Duration(seconds: 2),
        ));

  // static selectServerMessenger(BuildContext context, String text) =>
  //     ScaffoldMessenger.of(context)
  //       ..clearSnackBars()
  //       ..showSnackBar(SnackBar(
  //         content: CustomText.infoText(text),
  //         backgroundColor: AppColor.tertiaryColor,
  //         dismissDirection: DismissDirection.down,
  //         behavior: SnackBarBehavior.fixed,
  //         duration: const Duration(seconds: 2),
  //       ));

  // static snapshotMessenger(BuildContext context, bool isSuccess) =>
  //     ScaffoldMessenger.of(context)
  //       ..clearSnackBars()
  //       ..showSnackBar(SnackBar(
  //           padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
  //           content: Text(
  //             isSuccess ? StrLiteral.snapshotSaved : StrLiteral.snapshotError,
  //             style: const TextStyle(color: Colors.white),
  //           ),
  //           backgroundColor: AppColor.tertiaryColor,
  //           margin: const EdgeInsets.all(0),
  //           behavior: SnackBarBehavior.floating));
}