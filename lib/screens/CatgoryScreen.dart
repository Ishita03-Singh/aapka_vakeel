import 'package:aapka_vakeel/screens/phoneNumber_page.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: MyAppBar.appbar(context),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText.headText("Category"),
            Padding(padding: EdgeInsets.only(bottom: 28)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText.infoText("Choose your category"),
                Padding(padding: EdgeInsets.all(8)),
                customButton.taskButton("Advocate", () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: PhoneNumPage(first: true),
                          type: PageTransitionType.rightToLeft));
                }),
                Padding(padding: EdgeInsets.all(8)),
                customButton.taskButton("Client", () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: PhoneNumPage(),
                          type: PageTransitionType.rightToLeft));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
