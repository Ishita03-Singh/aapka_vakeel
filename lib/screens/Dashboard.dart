import 'package:aapka_vakeel/Utilities/strings.dart';
import 'package:aapka_vakeel/screens/OTPScreen.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  
   Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scrollContainer(),
      bottomNavigationBar: scBarContainer(),
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
                   SizedBox(height: 10,),
                   Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(child:
                    getDashboardwidger(StrLiteral.lawyerImage,"Affidavit/Agreement","Lorem Ipsum is simply dummy "),
                    ),
                    SizedBox(width: 20,),
                    Expanded(child:
                    getDashboardwidger(StrLiteral.lawyerImage,"Affidavit/Agreement","Lorem Ipsum is simply dummy "),
                    )
                   ],)
                   , SizedBox(height: 20,),
                   Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(child:
                    getDashboardwidger(StrLiteral.lawyerImage,"Affidavit/Agreement","Lorem Ipsum is simply dummy "),
                    ),
                    SizedBox(width: 20,),
                    Expanded(child:
                    getDashboardwidger(StrLiteral.lawyerImage,"Affidavit/Agreement","Lorem Ipsum is simply dummy "),
                    )
                   ],),
                    SizedBox(height: 20,),
                   Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(child:
                    getDashboardwidger(StrLiteral.lawyerImage,"Affidavit/Agreement","Lorem Ipsum is simply dummy "),
                    ),
                    SizedBox(width: 20,),
                    Expanded(child:
                    getDashboardwidger(StrLiteral.lawyerImage,"Affidavit/Agreement","Lorem Ipsum is simply dummy "),
                    )
                   ],)
                ],),
                       ),
             ],
           ),
         )
    );
  }


scBarContainer(){
    return 
       Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        Icon(Icons.home,size: 28),
         Icon(Icons.note,size: 28),
          Icon(Icons.leave_bags_at_home_outlined,size: 28),
           Icon(Icons.home,size: 28),
            Icon(Icons.home,size: 28)
        ],),
      
    );
  }
  getDashboardwidger(String img, String headText, String infoText ){
   return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
    border: Border.all(color: Color(0xFF333333).withOpacity(0.2),width: 1),
    color: Colors.white,
    boxShadow: [BoxShadow(
                  color: Color(0xFF333333).withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),] 
    ),
    child: Column(
      children: [
      Image.asset(img),
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CustomText.headText(headText),
          CustomText.infoText(infoText,isCenter: false),
        ],),
      )
    ],),
   );
  }
}
