import 'package:aapka_vakeel/HTTP/serverhttpHelper.dart';
import 'package:aapka_vakeel/model/AdvocateCall.dart';
import 'package:aapka_vakeel/model/advocate.dart';
import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/screens/consultation/advocateDetail.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/ratingChip.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ConsultLawyer extends StatefulWidget {
  const ConsultLawyer({super.key});

  @override
  State<ConsultLawyer> createState() => _ConsultLawyerState();
}

class _ConsultLawyerState extends State<ConsultLawyer> {
   
  TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _filteredItems=[];
  List<DocumentSnapshot> advocateList = [];
    final CollectionReference advocatesCollection =
      FirebaseFirestore.instance.collection('advocates');

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
        _filteredItems = advocateList;
      });
    }
  });

  // Add the search controller listener once
  _searchController.addListener(_filterList);
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
            getSearchButton(),
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
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(width: 1,color: Colors.grey),
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
        CustomChip.statusText(advocate["address"],false),
      ],)
      ,SizedBox(height: 5),
      CustomText.RegularDarkText("Call charges: Rs. ${advocate["charges"]}/min")
      ,SizedBox(height: 5),
      Row(
        children: [
        Expanded(child: 
        GestureDetector(
          onTap: (){
            //scheduleCall

            var advocateCall= new AdvocateCall(uid: userClass.uid, userName: userClass.displayName, phoneNumber: userClass.phoneNumber, callTime: DateTime.now().toString(), advocateName: advocate['firstName']+" "+ advocate['lastName'], advoacteId: advocate['id'],isVideoCall: false);
            userClass.advoacateCalls!.add(advocateCall);
          },
          child:Container(
            padding:EdgeInsets.fromLTRB(20,10,20,10),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black),
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
          onTap: (){

            //schedule 
               var advocateCall= new AdvocateCall(uid: userClass.uid, userName: userClass.displayName, phoneNumber: userClass.phoneNumber, callTime: DateTime.now().toString(), advocateName: advocate['firstName']+" "+ advocate['lastName'], advoacteId: advocate['id'],isVideoCall: false);
            userClass.advoacateCalls!.add(advocateCall);
          },
          child:Container(padding:EdgeInsets.fromLTRB(20,10,20,10),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black),
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
}