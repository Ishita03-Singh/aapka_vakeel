import 'dart:async';
import 'dart:io';

import 'package:aapka_vakeel/Utilities/strings.dart';
import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/screens/IntroScreen.dart';
import 'package:aapka_vakeel/screens/OTPScreen.dart';
import 'package:aapka_vakeel/screens/advocate/appointment.dart';
import 'package:aapka_vakeel/screens/advocate/notaryCalls.dart';
import 'package:aapka_vakeel/screens/affidavitScreen.dart';
import 'package:aapka_vakeel/screens/scbarContainer.dart';
import 'package:aapka_vakeel/services/authService.dart';
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

import '../chatGPT/chatGPT.dart';

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
 OverlayEntry? _popupOverlay; // To store the overlay entry
  bool _isPopupVisible = false;
  
   @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1),  _showPopup);
    Timer(Duration(seconds: 8),  _hidePopup);
    // print(widget.image!.path);
    if(widget.image==null)
    {
      getAdvocateImage();
    }
   
  }
  // Function to create the popup overlay entry
  OverlayEntry _createPopupOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: 130, // Position it above the floating action button
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
               boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                  spreadRadius: 5, // How much the shadow spreads
                  blurRadius: 7,   // Softening of the shadow
                  offset: Offset(0, 3), // X and Y offset for the shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(onPressed: _hidePopup, icon: Icon(Icons.close,color: Colors.grey,size: 20,)),
                CustomText.RegularDarkText("Hi, Got any legal query? I’m happy to help.",fontSize: 12),
              ],
            )
          ),
        ),
      ),
    );
  }


void _showPopup() {
    if (!_isPopupVisible) {
      _popupOverlay = _createPopupOverlay();
      Overlay.of(context)?.insert(_popupOverlay!);
      setState(() {
        _isPopupVisible = true;
      });
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
      floatingActionButton: 
       FloatingActionButton(
        shape: CircleBorder(),
        elevation: 10,
        backgroundColor: Colors.white,
        onPressed: (){
            setState(() {
                 _hidePopup();
                });
       
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: ChatScreen(),
                                    type: PageTransitionType.rightToLeft));
                            },
                            child:  Image.asset(StrLiteral.appLogoPath,width: 40,),),
      appBar: MyAppBar.appbar(context, showBackButton: false),
      body: scrollContainer(),
      bottomNavigationBar: advocateScBar(),
    );
  }

void _hidePopup() {
    if (_isPopupVisible) {
      _popupOverlay?.remove();
      setState(() {
        _isPopupVisible = false;
      });
    }
  }
  scrollContainer(){
    return WillPopScope(
        onWillPop: () async {
          final shouldLogout = await showLogoutConfirmationDialog(context);
          if (shouldLogout) {
            // Call your logout function here
            await onLogout();
            Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                child: IntroPage(),
                                type: PageTransitionType.rightToLeft), (route) => false); // Redirect to login or any desired page
          }
          return false; // Prevent default back navigation
        },
        child: SingleChildScrollView(
      child: 
         Container(
          height: MediaQuery.of(context).size.height,
           child: Column(
             children: [
              //  MyAppBar.appbar(context),
               Container(
                color: Color(0xFFE0E1DD),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20,bottom: 20),
                child: Row(
                  children:[
                      CircleAvatar( radius: 30,  
                      backgroundImage: widget.image==null?NetworkImage(imageURL):FileImage(File(widget.image!.path))  as ImageProvider<Object> ,
                      ),
                      SizedBox(width: 10),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    CustomText.boldDarkText("Welcome Back!"),
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
                          SizedBox(height: 10),
                           getCardContainer("Daily Calls List",StrLiteral.dailyCalls),
                          SizedBox(height: 10),
                            
                          GestureDetector(
                            onTap: (){
                              // AppointmentPage
                                 Navigator.push(
                        context,
                        PageTransition(
                            child: AppointmentPage(),
                            type: PageTransitionType.rightToLeft));
                            },
                            child:  getCardContainer("Appointments",StrLiteral.calender),),
                          SizedBox(height: 10),
                            getCardContainer("My Clients",StrLiteral.clients),
                          SizedBox(height: 10),
                            
                        ],
                      )
                      
                    ],
                  ),
                )
             ],
           ),
         )
    ));

  }

  Future<void> onLogout() async {
    // Add your logout logic here
    await AuthService.signOutUser();
    print("User logged out");
  }

  Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Confirm logout"),
            content: Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Yes"),
              ),
            ],
          ),
        ) ??
        false; // If the dialog is dismissed, return false
  }

  getCardContainer(String text,String image){
    return Card(
        color: Color(0xFFE0E1DD),
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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF0D1B2A),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.taskBtnText(text.split(" ")[0],fontsize: 12),
          CustomText.taskBtnText(text.split(" ")[1],fontsize: 12),
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
