import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_call/video_call.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
 final String documentId = userClass.phoneNumber; // The document ID for the consultation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultation List'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('consultation') // Main collection
            .doc(documentId) // Specific consultation document
            .collection('sessions') // Subcollection where sessions are stored
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
              var dateTime = DateTime.parse(consultation['callTime']); // Assuming `callTime` is a field

              return Card(
                
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(children: [
                    Text(consultation['userName'] ?? 'Unknown'),
                    Text( consultation['callTime'].split(' ')[0]+ " "+ '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}'),
                  ],)
                  ,customButton.smalltaskButton("Join call", (){
                    Navigator.of(context).pushReplacement(
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>JoinScreen(username: userClass.displayName,meetingId: userClass.phoneNumber,isJoin: false,
                                                                      )
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
