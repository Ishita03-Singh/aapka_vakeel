import 'dart:async';
import 'dart:io';

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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AdvocateDashboard extends StatefulWidget {
  User? user;
  UserClass? userclass;
  File? image;
  
  
   AdvocateDashboard({super.key, this.user,
  //  required this.userclass
  this.userclass,this.image
   });

  @override
  State<AdvocateDashboard> createState() => _AdvocateDashboardState();
}

class _AdvocateDashboardState extends State<AdvocateDashboard> {
String imageURL="";
  
   @override
  void initState() {
    super.initState();
    // print(widget.image!.path);
    if(widget.image==null)
    {
      getAdvocateImage();
    }
   
  }



   @override
  void dispose() {
    super.dispose();
  }

Future<void> getAdvocateImage() async {
  try {
    String phoneNumber = widget.userclass!.phoneNumber; // Use a unique identifier like phone number or ID
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('AdvocateImages/$phoneNumber.jpg');
    var url= await storageRef.getDownloadURL(); 
    setState(() {
      imageURL=url;
    });
  } catch (e) {
    throw Exception('Error fetching advocate image: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.appbar(context),
      body: scrollContainer(),
      bottomNavigationBar: advocateScBar(),
    );
  }

  scrollContainer(){
    return SingleChildScrollView(
      child: 
         Container(
          height: MediaQuery.of(context).size.height,
           child: Column(
             children: [
              //  MyAppBar.appbar(context),
               Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Row(
                  children:[
                      CircleAvatar( radius: 30,  
                      backgroundImage: widget.image==null?NetworkImage(imageURL):FileImage(File(widget.image!.path))  as ImageProvider<Object> ,
                      ),
                      SizedBox(width: 10),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    CustomText.appNameText("Welcome Back!"),
                    CustomText.headText(widget.userclass!.displayName),
                  ],),
                  ]
                ),
                       ),

                       //todays appointment
                Container(
                  padding: EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.RegularDarkText("Today’s Appointment"),
                      SizedBox(height: 5),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          getBlueContainer("Document Services","0"),
                          SizedBox(width: 10),
                          getBlueContainer("Slot Booking","0"),
                           SizedBox(width: 10),
                          getBlueContainer("Today’s Earnings","0"),
                            
                        ],
                      )
                      
                    ],
                  ),
                ),
                //Personal Desk
                Container(
                  padding: EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.RegularDarkText("Personal Desk"),
                      SizedBox(height: 5),
                      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          getCardContainer("My Cases",StrLiteral.cases),
                          SizedBox(width: 10),
                           getCardContainer("Daily Calls List",StrLiteral.dailyCalls),
                          SizedBox(width: 10),
                            getCardContainer("Appointments",StrLiteral.calender),
                          SizedBox(width: 10),
                            getCardContainer("My Clients",StrLiteral.clients),
                          SizedBox(width: 10),
                            
                        ],
                      )
                      
                    ],
                  ),
                )
             ],
           ),
         )
    );

  }

  getCardContainer(String text,String image){
    return Card(
      color: Colors.white,
      elevation: 10,
      child:Container(
        padding: EdgeInsets.all(12),
        child: (
          Row(children: [
          Image.asset(image,width: 40),
          SizedBox(width: 20),
          CustomText.RegularDarkText(text)
         
        ],)),
      )
    );
  }
getBlueContainer(String text,String number){
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.taskBtnText(text.split(" ")[0],fontsize: 15),
          CustomText.taskBtnText(text.split(" ")[1]),
          CustomText.taskBtnText(number)
        ],
      ),
    ),
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
