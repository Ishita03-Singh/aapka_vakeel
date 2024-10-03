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
  // List<UserClass> _filteredItems=[];
  // List<UserClass> advocateList = [];
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
    // _initializeAsync(); 
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


// Future<void> _initializeAsync() async {
//   List<UserClass> advocateList=await Serverhttphelper.getAdvocateList();
//     setState(() {
//       advocateList = advocateList;
//     });
//      _filteredItems.addAll(advocateList);
//   }


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




advoacteList(){
   return StreamBuilder<QuerySnapshot>(
      stream: advocatesCollection.snapshots(), // Listen to real-time changes
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // If data is available, display the list of advocates
        final List<DocumentSnapshot> docs = snapshot.data!.docs;

        return Container(
          padding: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width-40,
          height: MediaQuery.of(context).size.height-200,
          child: ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var advocate = docs[index].data() as Map<String, dynamic>;
              return getAdvocateContainer(advocate);

            },
          ),
        );
      },
    );
}

  getAdvocateContainer( Map<String, dynamic> advocate){
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
        getTopLayer(advocate),
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
getTopLayer(Map<String,dynamic> advocate){
 return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
 crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Row(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar( radius: 30,  
        backgroundImage:AssetImage(StrLiteral.slider3)
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