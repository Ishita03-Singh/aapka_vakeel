import 'dart:async';

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
import 'package:visibility_detector/visibility_detector.dart';

class IntroPage extends StatefulWidget {
  IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
   final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  // bool _isVisible = false;
  final List<Map> introScrolls = [
    {
      "headText":"Get guidance from trusted lawyers",
      "infoText":"Aapka Vakeel transforms how you access legal services, making professional legal assistance just a few clicks away, no matter where you are.", 
    },
     {
      "headText":"Get guidance from trusted lawyers",
      "infoText":"Embrace the future of law with Aapka Vakeel. Our innovative application combines technology with legal expertise to deliver unparalleled service.",
    },
     {
     "headText":"Get guidance from trusted lawyers",
    "infoText":"Experience legal excellence with Aapka Vakeel. Our platform delivers expert legal solutions right to your device, making legal help more accessible than ever.",
    }
    ];

     @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }
 void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      // if (_isVisible) {
        if (_currentPage < 2) {
          setState(() {
          _currentPage++;
          });
        } else {
          setState(() {
          _currentPage = 0; 
          });
        }
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      // }
    });
  }
   @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  getScrollWigets(){
      return  Container(
        height: 180.0, // Height of the horizontal scroll view
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: introScrolls.length,
          itemBuilder: (context, index) {
        return Column(
         children: [CustomText.appNameText(introScrolls[index]["headText"],
                          isCenter: true),
                      Padding(padding: EdgeInsets.all(3)),
                      CustomText.infoText(introScrolls[index]["infoText"],
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
                              color: index==0?Colors.black:Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                              color: index==1?Colors.black:Colors.white,
                              
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
                              color: index==2?Colors.black:Colors.white,
                            ),
                          )
                        ],
                      ),
                          ],
        );})
      
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: MyAppBar.appbar(context),
      body: Container(
        padding: EdgeInsets.only(top:26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  StrLiteral.intro1,
                ),
                Image.asset(
                  StrLiteral.intro2, 
                ),
              ],
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
                    getScrollWigets(),
                    Padding(padding: EdgeInsets.all(4)),
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
