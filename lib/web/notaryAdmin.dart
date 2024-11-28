import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_call/video_call.dart';

class NotaryAdmin extends StatefulWidget {
  static const String routeName = '/notaryAdmin';
  const NotaryAdmin({super.key});

  @override
  State<NotaryAdmin> createState() => _NotaryAdminState();
}

class _NotaryAdminState extends State<NotaryAdmin> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signin();
  }

   
   signin()async{
 UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: 'dhruvlegalaid@gmail.com',password: 'Manmohan@0');
   }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Notary Requests'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('notaryCalls') // Main collection
            .get(), // Get all documents in 'sessions' subcollection
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No consultations found'));
          }

          final consultations = snapshot.data!.docs;

          return ListView.builder(
            itemCount: consultations.length,
            itemBuilder: (context, index) {
              var consultation = consultations[index];
              print(consultation);
              // var dateTime = DateTime.parse(consultation['callTime']); // Assuming `callTime` is a field
              var dateTime =DateTime.now();
              return Card(
                
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                    Text(consultation['name'] ?? 'Unknown'),
                    Text( consultation['callTime'].split(' ')[0]+ " "+ '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}'),
                  ],)
                  ,customButton.smalltaskButton("Join call", (){
                    Navigator.of(context).pushReplacement(
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>JoinScreen(username: userClass.displayName,meetingId: userClass.phoneNumber,isJoin: false,)
                                                                      // VideoCall(data: snapshot.data!),
                                                                    ));
                  })
                ],),
              ),
               
              );
            },
          );
        },
      ),
    );
  }
}





