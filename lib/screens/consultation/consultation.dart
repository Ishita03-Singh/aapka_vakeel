import 'dart:convert';

import 'package:aapka_vakeel/HTTP/serverhttpHelper.dart';
import 'package:aapka_vakeel/model/AdvocateCall.dart';
import 'package:aapka_vakeel/model/advocate.dart';
import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/dateTimePicker.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/screens/consultation/advocateDetail.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/cutom_message.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/ratingChip.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:page_transition/page_transition.dart';

class ConsultLawyer extends StatefulWidget {
  const ConsultLawyer({super.key});

  @override
  State<ConsultLawyer> createState() => _ConsultLawyerState();
}

class _ConsultLawyerState extends State<ConsultLawyer> {
   
  TextEditingController _searchController = TextEditingController();
  TextEditingController _locationController= TextEditingController();
  List<DocumentSnapshot> _filteredItems=[];
  List<DocumentSnapshot> advocateList = [];
  final CollectionReference advocatesCollection =
      FirebaseFirestore.instance.collection('advocates');
// 
  // String _searchQuery = userClass.address.split(',')[1];




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  MyAppBar.appbar(context,head:"Talk To a Lawyer"),
       body: ConsultationScroll(),
    );
  }

 @override
  void initState() {
    super.initState();
    _initializeAsync();
  }

void _initializeAsync() {
  // Listen to Firestore's snapshot stream
  advocatesCollection.snapshots().listen((snapshot) {
    if (snapshot != null) {
      final List<DocumentSnapshot> docs = snapshot.docs;

      // Update the state without using StreamBuilder
      setState(() {
        advocateList = docs;
        var t=userClass.address.split(',');
        _locationController.text=userClass.address.split(',')[1];
        _filteredItems = advocateList;

      });
    }
  });

  // Add the search controller listener once
  _searchController.addListener(_filterList);
   _locationController.addListener(_filteredLawyers);
}
// _initializeAsync(){
//   StreamBuilder<QuerySnapshot>(
//       stream: advocatesCollection.snapshots(), // Listen to real-time changes
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }

//         // If data is available, display the list of advocates
//         final List<DocumentSnapshot> docs = snapshot.data!.docs;
//         setState(() {
//            advocateList=docs;
//         });
//         _filteredItems=advocateList;
//          _searchController.addListener(_filterList);
//          return Container();
//       });
// }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }




  getAdvoactes(){

  }

void _filterList() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = advocateList.where((item) {
       var advocate = item.data() as Map<String, dynamic>;
       String fullName = (advocate['firstName'] + " " + advocate['lastName']).toLowerCase();
      return fullName.contains(query);
    }).toList();
      print(_filteredItems);
    });
  }
  void _filteredLawyers() {
    String query = _locationController.text.toLowerCase();
    setState(() {
      _filteredItems = advocateList.where((item) {
       var advocate = item.data() as Map<String, dynamic>;
       String city = advocate['address'].split(',')[1].toLowerCase();
      return city.contains(query);
    }).toList();
      print(_filteredItems);
    });
  }



// void _filterItems(String query) {
//     List<UserClass> results = [];
//     if (query.isEmpty) {
//       results.addAll(advocateList);
//     } else {
//       results = advocateList
//           .where((item) => item.displayName.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     setState(() {
//       _filteredItems = results;
//     });
//   }

  ConsultationScroll(){
    
    return Column(
      children: [
          // MyAppBar.appbar(context,head:"Talk To a Lawyer"),
          Padding(
            padding:  EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(  
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: MediaQuery.of(context).size.width-200,
                    child: getSearchButton()),
                  // Location Field
                  Container(width: 150,
                    child: TextField(
                    controller: _locationController,
                    // onChanged: _filterItems,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      labelText: "Location",
                      prefixIcon: Icon(Icons.pin_drop_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                                    ),
                  )
                ],
                            ),
              )
            ,
            advoacteList(),
            ],),
          )
         
      ],
    );
  }

  getSearchButton(){
  return TextField(
                controller: _searchController,
                // onChanged: _filterItems,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  labelText: 'Search..',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    // borderSide: ,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              );
  }



Widget advoacteList() {
  return Container(
    padding: EdgeInsets.only(top: 20),
    width: MediaQuery.of(context).size.width - 40,
    height: MediaQuery.of(context).size.height - 200,
    child: ListView.builder(
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        var advocate = _filteredItems[index].data() as Map<String, dynamic>;

        // Use FutureBuilder to fetch the image URL asynchronously
        return FutureBuilder<String>(
          future: getAdvocateImage(advocate), // Asynchronous image URL fetching
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||snapshot.hasError ) {
               return getAdvocateContainer(advocate, ""); 
            } else if (snapshot.hasData) {
              String? imageUrl = snapshot.data;
              return getAdvocateContainer(advocate, imageUrl!); 
            } else {
              return getAdvocateContainer(advocate, ""); 
            }
          },
        );
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

  getAdvocateContainer( Map<String, dynamic> advocate,String imageUrl){
 return GestureDetector(
  onTap:(){
      Navigator.push(
                        context,
                        PageTransition(
                            child: AdvocateDetail(advocate:advocate),
                            type: PageTransitionType.rightToLeft));
  },
   child: Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(width: 1,color: Colors.black.withOpacity(0.2)),
      borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //top layer
        getTopLayer(advocate,imageUrl),
        SizedBox(height: 10),
        getMiddleLayer(advocate),
        SizedBox(height: 10),
        getBottomLayer(advocate),
   
   
    ],),
    ),
 );
  }


getBottomLayer(Map<String,dynamic> advocate){
  return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(children: [
        CustomChip.statusText("Available",true),
        SizedBox(width: 20),
       Container(child: CustomText.infoText(advocate["address"]),width: MediaQuery.of(context).size.width/2,),
      ],)
      ,SizedBox(height: 5),
      CustomText.RegularDarkText("Call charges: Rs. ${advocate["charges"]}/min")
      ,SizedBox(height: 5),
      Row(
        children: [
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
            
            var advocateCall= new AdvocateCall(uid: userClass.uid, userName: userClass.displayName, phoneNumber: userClass.phoneNumber, callTime: combinedDateTime.toString(), advocateName: advocate['firstName']+" "+ advocate['lastName'],isVideoCall: false,advoacteId: advocate['phoneNumber']);
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

            //schedule 

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

               var advocateCall= new AdvocateCall(uid: userClass.uid, userName: userClass.displayName, phoneNumber: userClass.phoneNumber, callTime: combinedDateTime.toString(), advocateName: advocate['firstName']+" "+ advocate['lastName'],isVideoCall: false,advoacteId: advocate['phoneNumber']);
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
       await  storeCallDetails();

                       CustomMessenger.defaultMessenger(context, "Call Scheduled at "+combinedDateTime.toString());

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
      ],)
    ],
  );
}
getMiddleLayer(Map<String,dynamic> advocate){
return Container(
  padding: EdgeInsets.only(right: 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Column(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
   Container(
    width: MediaQuery.of(context).size.width/2,
    child: CustomText.smallheadText(advocate['skills'])),
   SizedBox(height: 5),
   CustomText.infoText("${advocate['experience']} years of Experience"),
  //  CustomText.infoText("Tamil, Marathi, English, Hindi, Karnataka, Telugu")
    ],),
    // Icon(Icons.thumb_up_outlined,color: Colors.grey,size: 25,)
   
  
  ],),
);
}
getTopLayer(Map<String,dynamic> advocate,String imageUrl){
 return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
 crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Row(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     
      CircleAvatar( radius: 30,  
        backgroundImage: imageUrl==""?AssetImage(StrLiteral.slider3)  as ImageProvider<Object> : NetworkImage(imageUrl),
        ),
    SizedBox(width: 10),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //name and tick
        Row(children: [CustomText.boldDarkText(advocate['firstName']+" "+ advocate['lastName']),SizedBox(width: 5,),
        // Image.asset(StrLiteral.blueTick)
        ],)
        ,Container(
          width: MediaQuery.of(context).size.width/2,
          child: CustomText.infoText(advocate["introduction"])),
      ],
    )],
  ),
  // Column(crossAxisAlignment: CrossAxisAlignment.end,
  // children: [  CustomChip.getRatingChip(4.8),
  // CustomText.infoText("1052 Reviews")],)

],);
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