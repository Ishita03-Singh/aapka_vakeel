import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppBar {
  static appbar(
    BuildContext context, {
    String head = StrLiteral.appName,
    bool showBackButton = true, // Show/hide back button (default is true)
    VoidCallback? onBackPressed, // Callback for the back button
  }) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            )
          : null, // If false, no back button is shown
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Align(
        alignment: Alignment.centerLeft,
        child: CustomText.appNameText(head),
      ),
      backgroundColor: AppColor.bgColor,
      actions: [
        customButton.iconButton(
          context,
          "Help",
          Icons.help_outline_rounded,
              () {
            launchURL('https://example.com'); // Replace with your URL
          },
        )
      ],
    );
  }

  static Future<void> launchURL(String url) async {
    // Check if the URL can be launched
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
