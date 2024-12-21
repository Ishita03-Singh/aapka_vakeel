import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/screens/notaryScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:aapka_vakeel/screens/videoCall.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_call/video_call.dart';

class AsyncLoader extends StatefulWidget {
  var username;
  var meetingId;
   AsyncLoader({super.key,required this.username,required this.meetingId});

  @override
  State<AsyncLoader> createState() => _AsyncLoaderState();
}

class _AsyncLoaderState extends State<AsyncLoader> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _fcmToken;

var meetingId="";

   @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }


  Future<void> _initializeFirebaseMessaging() async {
    // Request notification permissions (for iOS)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // Get the FCM token for the device
    _fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $_fcmToken");

    // Handle background messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title} - ${message.notification?.body}');
    });
  }


  @override
  Widget build(BuildContext context) {
     return  Scaffold(
      body: FutureBuilder<String>(
        future: fetchData(),
        builder: (context, snapshot) {
          print("FutureBuilder state: ${snapshot.connectionState}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return WaitingArea();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              print("Data received: ${snapshot.data}");
              // var meetingId="";
              // Navigate to the next screen once data is received
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>JoinScreen(username: widget.username,meetingId: meetingId,)
                    // VideoCall(data: snapshot.data!),
                  ),
                );
              });
              return Container(); // Empty container while waiting for navigation
            } else if (snapshot.hasError) {
              print("Error: ${snapshot.error}");
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          }
          return Center(child: Text('Unexpected state'));
        },
      ),
    );
  }

  Future<String> fetchData() async {
    print("Fetching data...");
   fetchAdvocateUsers();
   return "Data recieved";
  }

  Future<void> sendNotification(String token, String title, String body) async {
  try {
    //get current user
     FirebaseMessaging messaging = FirebaseMessaging.instance;
    
    var user= FirebaseAuth.instance.currentUser;
    meetingId = user!=null?user.uid:"meetingid";
      String? user_token = await messaging.getToken();
   
if(user!=null)
    await FirebaseMessaging.instance.sendMessage(
      to: token,
      data:{
        "user":user_token!,
        "meetingId": meetingId


      }
      // notification: RemoteNotification(
      //   title: title,
      //   body: body,
      // ),
    );
    print("Notification sent to $token");
  } catch (e) {
    print("Error sending notification: $e");
  }
}

void notifyAdvocateUsers() async {
  List<Map<String, dynamic>> advocateUsers = await fetchAdvocateUsers();
  
  for (var user in advocateUsers) {
    String message = "Hello ${user['name']}, new updates for advocates!";
    sendNotification(user['fcmToken'], "Advocate Update", message);
  }
}

Future<List<Map<String, dynamic>>> fetchAdvocateUsers() async {
  List<Map<String, dynamic>> advocateUsers = [];
  
  try {
    CollectionReference advocatesRef = FirebaseFirestore.instance.collection('advocates');
    QuerySnapshot snapshot = await advocatesRef.get();

    snapshot.docs.forEach((doc) {
      advocateUsers.add({
        'name': doc['name'],
        'fcmToken': doc['fcmToken'],
      });
    });

    return advocateUsers;
  } catch (e) {
    print("Error fetching advocate users: $e");
    return [];
  }
}
}