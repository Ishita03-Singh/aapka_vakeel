import 'package:aapka_vakeel/screens/CatgoryScreen.dart';
import 'package:aapka_vakeel/screens/phoneNumber_page.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

class IntroPage extends StatefulWidget {
  IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: MyAppBar.appbar(context),
      body: Container(
        // padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              StrLiteral.appLogoPath,
              width: 100,
              height: 200,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Color(0xffECECEC),
                    // color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(padding: EdgeInsets.all(16)),
                    CustomText.appNameText("Get guidance from trusted lawyers",
                        isCenter: true),
                    Padding(padding: EdgeInsets.all(3)),
                    CustomText.infoText(
                        'Lorem Ipsum is simply dummy text of the  printing and typesetting industry. Lorem Ipsm has been dummy text ever since the 1500s',
                        isCenter: true),
                    Padding(padding: EdgeInsets.all(12)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          width: 25,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            color: Colors.white,
                          ),
                          width: 25,
                          height: 4,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          width: 25,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    customButton.cancelButton("Login", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneNumPage(
                                    first: false,
                                    isAdvocate: false,
                                  )));
                    }),
                    Padding(padding: EdgeInsets.all(8)),
                    customButton.taskButton("Sign-up", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()));
                    }),
                    Padding(padding: EdgeInsets.all(6)),
                    CustomText.cancelBtnText('Looking for help?', fontsize: 13)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
