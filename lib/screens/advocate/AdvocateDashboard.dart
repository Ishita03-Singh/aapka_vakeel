import 'dart:async';

import 'package:aapka_vakeel/Utilities/strings.dart';
import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/screens/OTPScreen.dart';
import 'package:aapka_vakeel/screens/advocate/notaryCalls.dart';
import 'package:aapka_vakeel/screens/affidavitScreen.dart';
import 'package:aapka_vakeel/screens/scbarContainer.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AdvocateDashboard extends StatefulWidget {
  User? user;
  UserClass? userclass;
  
   AdvocateDashboard({super.key, this.user,
  //  required this.userclass
  this.userclass
   });

  @override
  State<AdvocateDashboard> createState() => _AdvocateDashboardState();
}

class _AdvocateDashboardState extends State<AdvocateDashboard> {

  
   @override
  void initState() {
    super.initState();
  }


   @override
  void dispose() {
    
    super.dispose();
  }
  
  







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scrollContainer(),
      bottomNavigationBar: ScBar(),
    );
  }

  scrollContainer(){
    return SingleChildScrollView(
      child: 
         Container(
           child: Column(
             children: [
               MyAppBar.appbar(context),
               Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  CustomText.headText("Welcome!"),
                  CustomText.infoText("How can we be of help?"),
                   SizedBox(height: 10),
                  //  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //   Expanded(child:
                  //   getDashboardwidger(StrLiteral.affidavit,"Affidavit/Agreement","Lorem Ipsum is simply dummy "),
                  //   ),
                  //   SizedBox(width: 20,),
                  //   Expanded(child:
                  //   getDashboardwidger(StrLiteral.consultation,"Legal Consultation","Lorem Ipsum is simply dummy "),
                  //   )
                  //  ],)
                  //  , SizedBox(height: 20,),
                   Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(child:
                    getDashboardwidger(StrLiteral.challan,"Fill Challan","Lorem Ipsum is simply dummy "),
                    ),
                    SizedBox(width: 20,),
                    Expanded(child:
                    getDashboardwidger(StrLiteral.stampPaper,"Stamp Paper","Lorem Ipsum is simply dummy "),
                    )
                   ],),
                    SizedBox(height: 20,),
                   Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(child:
                    getDashboardwidger(StrLiteral.GST,"GST","Lorem Ipsum is simply dummy "),
                    ),
                    SizedBox(width: 20,),
                    Expanded(child:
                    getDashboardwidger(StrLiteral.tradeMark,"Trademark","Lorem Ipsum is simply dummy "),
                    )
                   ],),
                   SizedBox(height: 20),
                  
                  

                ],),
                       ),
             ],
           ),
         )
    );
  }





  getDashboardwidger(String img, String headText, String infoText ){
   return GestureDetector(
    onTap: () {
      // AffidavitScreen
      Navigator.push(
                        context,
                        PageTransition(
                            child: NotaryCalls(),
                            type: PageTransitionType.rightToLeft));
    },
     child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: Color(0xFF333333).withOpacity(0.2),width: 1),
      color: Colors.white,
      boxShadow: [BoxShadow(
                    color: Color(0xFF333333).withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),] 
      ),
      child: Column(
        children: [
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), 
          child: Image.asset(img,fit: BoxFit.fill,height: 140,)),
        Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            CustomText.smallheadText(headText),
            CustomText.extraSmallinfoText(infoText,isCenter: false),
          ],),
        )
      ],),
     ),
   );
  }
}
