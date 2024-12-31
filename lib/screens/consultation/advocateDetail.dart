import 'dart:convert';

import 'package:aapka_vakeel/model/AdvocateCall.dart';
import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/cutom_message.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../others/dateTimePicker.dart';
import '../../others/shared_pref.dart';
import '../../utilities/custom_text.dart';
import '../../utilities/ratingChip.dart';
import '../../utilities/strings.dart';

class AdvocateDetail extends StatefulWidget {
  Map<String,dynamic> advocate;
   AdvocateDetail({super.key,required this.advocate});

  @override
  State<AdvocateDetail> createState() => _AdvocateDetailState();
}

class _AdvocateDetailState extends State<AdvocateDetail> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body:
     FutureBuilder<String>(
          future:  getAdvocateImage(widget.advocate), // Asynchronous image URL fetching
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||snapshot.hasError ) {
               return AdvoacteDetail(""); 
            } else if (snapshot.hasData) {
              String? imageUrl = snapshot.data;
              return AdvoacteDetail(imageUrl!); 
            } else {
              return AdvoacteDetail(""); 
            }
          },
        ),
     
    );
  }
  Future<String> getAdvocateImage(Map<String, dynamic> advocate) async {
  try {
    String phoneNumber = advocate['phoneNumber']; // Use a unique identifier like phone number or ID
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('AdvocateImages/$phoneNumber.jpg');
    var url= await storageRef.getDownloadURL(); 
    return url;// Return the download URL
  } catch (e) {
    throw Exception('Error fetching advocate image: $e');
  }
}

  AdvoacteDetail(String imageUrl){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
              MyAppBar.appbar(context,head:"Lawyer’s Details"),
              Padding(
                padding:  EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: 
                Column(  
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                lawyerInfo(imageUrl),
                SizedBox(height: 15),
                ExpAndLanguage(),
                SizedBox(height: 15),
                CallDetail(),
                SizedBox(height: 15),
                offerings(),
                SizedBox(height: 25),
                // achievements(),
                // PracticeArea(),
                callButtons(),
                ],),
              )
             
          ],
        ),
      ),
    );
  }
  CallDetail(){
    return  Card(
            elevation: 4,
            color: Colors.white, // Sets the elevation to create shadow
            shadowColor: Colors.grey, // Sets shadow color to grey
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Optional: Rounds the corners
            ),
            child: Column(
              children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      color: Color(0xFFD9D9D9)
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      CustomText.infoText("Call Charges:"),
                      CustomText.smallheadText(" Rs. ${widget.advocate['charges']}/min"),
                    ],),
                  ),
                   Container(
                     padding: EdgeInsets.all(10),
                     child: Column(
                       children: [
                         Row(children: [
                            CustomChip.statusText("Available",true),
                            SizedBox(width: 20),
                            Container(width: MediaQuery.of(context).size.width/2,
                              child: CustomText.infoText(widget.advocate["address"])),
                          ],),
                          SizedBox(height: 16)
                    ,Container(height: 1,color: Colors.grey,),
                    SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Container(width: MediaQuery.of(context).size.width/2,
                      child: CustomText.infoText("Talk to this lawyer byscheduling a call")),
                    CustomButton.IconTextOutlineButton("Schedule",Icons.calendar_month,()async {
                              //scheduleCall

             var date =await customDateTimePicker.selectDate(context);
             if (date == null) return; // User canceled the picker
             var time= await customDateTimePicker.selectTime(context);
             if (time == null) return; // User canceled the picker
             DateTime combinedDateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );
            
            var advocateCall= new AdvocateCall(uid: userClass.uid, userName: userClass.displayName, phoneNumber: userClass.phoneNumber, callTime: combinedDateTime.toString(), advocateName: widget.advocate['firstName']+" "+ widget.advocate['lastName'],isVideoCall: false,advoacteId: widget.advocate['phoneNumber']);
            userClass.advoacateCalls!.add(advocateCall);
await FirebaseFirestore.instance
    .collection('consultation')
    .doc(advocateCall.advoacteId)
    .collection('sessions')
    .doc(combinedDateTime.toString()) // replace with a unique ID, like a timestamp or UUID
    .set({
      'userName': advocateCall.userName,
      'phone': userClass.phoneNumber,
      'email': userClass.email,
      'address': userClass.address,
      'callTime': combinedDateTime.toString(),
      'advocateName': advocateCall.advocateName,
      'advocateId': advocateCall.advoacteId,
      'isVideoCall': 'false',
    });
    
           await storeCallDetails();
            CustomMessenger.defaultMessenger(context, "Call Scheduled at "+combinedDateTime.toString());
            
                    })
                  ],)
                       ],
                     ),
                   )
               
              ],
            ),
          );
  }

  lawyerInfo(String imageUrl){
    return  Row(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     CircleAvatar( radius: 50,  
        backgroundImage: imageUrl==""?AssetImage(StrLiteral.slider3)  as ImageProvider<Object> : NetworkImage(imageUrl),
        ),
    SizedBox(width: 20),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //name and tick
        Row(children: [CustomText.appNameText(widget.advocate['firstName']+" "+ widget.advocate['lastName']),SizedBox(width: 5,),
        // Image.asset(StrLiteral.blueTick)
        ],)
        ,Container(width: MediaQuery.of(context).size.width/2,
          child: CustomText.infoText(widget.advocate['introduction'])),
      ],
    )],
  );
  }

  ExpAndLanguage(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CustomText.smallheadText("${widget.advocate['experience']} of Experience"),
      SizedBox(height: 7),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        // CustomText.infoText("Tamil, Marathi, English, Hindi, Karnataka, Telugu"),
        // Icon(Icons.thumb_up_outlined,color: Colors.grey,size: 25,)
    
      ],)
    ],);
  }
  offerings(){
    return Card(
            elevation: 4,
            color: Colors.white, // Sets the elevation to create shadow
            shadowColor: Colors.grey, // Sets shadow color to grey
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Optional: Rounds the corners
            ),
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [  
                CustomText.boldDarkText("My other offerings"),
                SizedBox(height: 5),
                Row(
                  children: [
                  Container(width: MediaQuery.of(context).size.width/3-30,
                  height: 200,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))
                    ,border: Border.all(color: Colors.grey)),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.file_copy,color: Colors.black,size: 40),
                      CustomText.smallheadText("Legal Document Review")
                    ],),
                  ),
                  SizedBox(width: 5),
                   Container(width: MediaQuery.of(context).size.width/3-30,
                   height: 200,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))
                    ,border: Border.all(color: Colors.grey)),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.file_copy,color: Colors.black,size: 40),
                      CustomText.smallheadText("PersonalAppointment")
                    ],),
                  ),
                  SizedBox(width: 5),
                   Container(width: MediaQuery.of(context).size.width/3-30,
                   height: 200,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))
                    ,border: Border.all(color: Colors.grey)),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.file_copy,color: Colors.black,size: 40),
                      CustomText.smallheadText("Send Legal Notice")
                    ],),
                  )
                ],)
                         ],
               ),
            ),
            );
  }
  

  callButtons(){
    return Row(
        children: [
        Expanded(child: 
        GestureDetector(
          onTap: ()async {
            //scheduleCall
   var date =await customDateTimePicker.selectDate(context);
             if (date == null) return; // User canceled the picker
             var time= await customDateTimePicker.selectTime(context);
             if (time == null) return; // User canceled the picker
             DateTime combinedDateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );
            var advocateCall= new AdvocateCall(uid: userClass.uid, userName: userClass.displayName, phoneNumber: userClass.phoneNumber, callTime: combinedDateTime.toString(), advocateName: widget.advocate['firstName']+" "+ widget.advocate['lastName'], advoacteId: widget.advocate['phoneNumber'],isVideoCall: false);
            userClass.advoacateCalls!.add(advocateCall);

            await FirebaseFirestore.instance.collection('consultation').doc(userClass.uid).set({
          'userName':userClass.displayName,
          'phone': userClass.phoneNumber,
          'email': userClass.email,
          'address':userClass.address,
          'callTime':combinedDateTime.toString(),
          'advocateName':advocateCall.advocateName,
          'advocateId':advocateCall.advoacteId,
          'isVideoCall':'false',

          // 'city':CityController.text,
          // 'pinCode':PinCodeController.text,
        });
        await storeCallDetails();

            CustomMessenger.defaultMessenger(context, "Call Scheduled");
          },
          child:Container(
            padding:EdgeInsets.fromLTRB(20,10,20,10),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color(0xFF0D1B2A)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.call,color: Colors.white,size: 18),
              SizedBox(width: 10),
              Text("Audio Call" ,style: TextStyle(color: Colors.white,fontSize: 18),)
            ],),
          )
        )),
        SizedBox(width: 10),
        Expanded(child: 
           GestureDetector(
          onTap: ()async{
                    //scheduleCall
                       var date =await customDateTimePicker.selectDate(context);
             if (date == null) return; // User canceled the picker
             var time= await customDateTimePicker.selectTime(context);
             if (time == null) return; // User canceled the picker
             DateTime combinedDateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );


            var advocateCall= new AdvocateCall(uid: userClass.uid, userName: userClass.displayName, phoneNumber: userClass.phoneNumber, callTime: combinedDateTime.toString(), advocateName: widget.advocate['firstName']+" "+ widget.advocate['lastName'], advoacteId: widget.advocate['phoneNumber'],isVideoCall: true);
            userClass.advoacateCalls!.add(advocateCall);
            await FirebaseFirestore.instance.collection('consultation').doc(userClass.uid).set({
          'userName':userClass.displayName,
          'phone': userClass.phoneNumber,
          'email': userClass.email,
          'address':userClass.address,
          'callTime':combinedDateTime.toString(),
          'advocateName':advocateCall.advocateName,
          'advocateId':advocateCall.advoacteId,
          'isVideoCall':'true',

          // 'city':CityController.text,
          // 'pinCode':PinCodeController.text,
        });
          await storeCallDetails();
            CustomMessenger.defaultMessenger(context, "Call Scheduled");

          },
          child:Container(padding:EdgeInsets.fromLTRB(20,10,20,10),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color(0xFF0D1B2A)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Icon(Icons.videocam,color: Colors.white,size: 18),
              SizedBox(width: 10),
              Text("Video Call" ,style: TextStyle(color: Colors.white,fontSize: 18),)
            ],),
          )
        ))
      ],);
  }
  //achievments
 achievements(){
  return Column(children: [
   CustomText.boldDarkText("Achievements"),
   Row(children: [
    Column(children: [
      
    ],)
   ],)
  ]);
 }
 storeCallDetails()async{
  List<String> storeString=[];
  userClass.advoacateCalls!.forEach((call){
   call.toJson();
   storeString.add(jsonEncode(call));
  });
   MySharedPreferences.instance.setAdvocateCallList(storeString);
}
}