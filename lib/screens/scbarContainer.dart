import 'package:aapka_vakeel/screens/Dashboard.dart';
import 'package:aapka_vakeel/screens/UserProfile.dart';
import 'package:aapka_vakeel/screens/settings.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_call/utils/custom_text.dart';

class ScBar extends StatelessWidget {
  const ScBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: Dashboard(),
                      type: PageTransitionType.rightToLeft));
            },
            child: Image.asset(StrLiteral.home_filled, width: 28),
          ),
          // Image.asset(StrLiteral.note,width:28),
          // Image.asset(StrLiteral.advocate,width:30),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: Settings(),
                        type: PageTransitionType.rightToLeft));
              },
              child: Image.asset(StrLiteral.setting, width: 28)),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: UserProfile(),
                        type: PageTransitionType.rightToLeft));
              },
              child: Image.asset(StrLiteral.profile, width: 28)),
        ],
      ),
    );
  }
}

class advocateScBar extends StatelessWidget {
  const advocateScBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
           onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: UserProfile(),
                      type: PageTransitionType.rightToLeft));
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(StrLiteral.home_filled, width: 28),
                  CustomText.RegularDarkText("Home", fontSize: 12)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: UserProfile(),
                      type: PageTransitionType.rightToLeft));
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(StrLiteral.profile, width: 28),
                  CustomText.RegularDarkText("Bookings", fontSize: 12)
                ],
              ),
            ),
          ),
          GestureDetector(
           onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: UserProfile(),
                      type: PageTransitionType.rightToLeft));
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(StrLiteral.calender, width: 28),
                  CustomText.RegularDarkText("E courts", fontSize: 12)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: UserProfile(),
                      type: PageTransitionType.rightToLeft));
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(StrLiteral.cases, width: 28),
                  CustomText.RegularDarkText("My cases", fontSize: 12)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: UserProfile(),
                      type: PageTransitionType.rightToLeft));
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(StrLiteral.profile, width: 28),
                  CustomText.RegularDarkText("Profile", fontSize: 12)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
