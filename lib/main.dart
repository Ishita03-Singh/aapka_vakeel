import 'dart:convert';

import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/pushNotificationService.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/screens/AdvocateRegisterScreen.dart';
import 'package:aapka_vakeel/screens/Dashboard.dart';
import 'package:aapka_vakeel/screens/DashboardScreen.dart';
import 'package:aapka_vakeel/screens/IntroScreen.dart';
import 'package:aapka_vakeel/screens/advocate/AdvocateDashboard.dart';
import 'package:aapka_vakeel/screens/affidavitScreen.dart';
import 'package:aapka_vakeel/screens/asyncLoader.dart';
import 'package:aapka_vakeel/screens/notaryScreen.dart';
import 'package:aapka_vakeel/screens/paymentGateway.dart';
import 'package:aapka_vakeel/screens/phoneNumber_page.dart';
import 'package:aapka_vakeel/screens/CatgoryScreen.dart';
import 'package:aapka_vakeel/screens/stampPaper.dart';
import 'package:aapka_vakeel/screens/videoCall.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'screens/firebasedemo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  
  await Firebase.initializeApp(
    options: FirebaseOptions(
  apiKey: "AIzaSyBJntYd6x55mMJ41I3e-zmDqrIvXTWdzyk",
  authDomain: "appkavakeel-66df5.firebaseapp.com",
  projectId: "appkavakeel-66df5",
  storageBucket: "appkavakeel-66df5.appspot.com",
  messagingSenderId: "361879211179",
  appId: "1:361879211179:android:5580e59b999ceb22c3bbee",
  measurementId: "G-CV0KKNLDLS"
      
  ));
    // final fcmToken = await FirebaseMessaging.instance.getToken();
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
   FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true, // optional
  sslEnabled: true, // optional
  cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED, // optional
  ignoreUndefinedProperties: false, // optional
  // Set long polling timeout (minimum 5 seconds)
  webExperimentalLongPollingOptions: WebExperimentalLongPollingOptions(
    timeoutDuration: Duration(seconds: 10),
  ),  // Set to at least 5 seconds (you can increase if needed)
  webExperimentalForceLongPolling: true,  // Enable long polling
  );
 
  // FirebaseMessaging.onBackgroundMessage(PushNotificationService.backgroundHandler);
  await AppColor.setCurrentTheme();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // final PushNotificationService _notificationService = PushNotificationService();

   MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  PushNotificationService.initialize();
    SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: AppColor.bgColor,
        systemNavigationBarColor: AppColor.bgColor);
    return GlobalLoaderOverlay(
      child: MaterialApp(
        title: StrLiteral.appName,
        debugShowCheckedModeBanner: false,
      
        theme: ThemeData(
            // iconTheme: IconThemeData(color: AppColor.iconColor),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColor.bgColor,
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: AppColor.tertiaryColor.withOpacity(0.5),
              selectionHandleColor: AppColor.tertiaryColor,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColor.tertiaryColor),
            )),
            scrollbarTheme: const ScrollbarThemeData().copyWith(
                thumbColor:
                    MaterialStateProperty.all(AppColor.secondaryTextColor))),
      
        home: AnimatedSplashScreen.withScreenFunction(
          duration: 1000,
          animationDuration: const Duration(milliseconds: 900),
          curve: Curves.easeInSine,
          splash: Image.asset(StrLiteral.appLogoPath),
          splashIconSize: 250,
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.rightToLeftWithFade,
          backgroundColor: AppColor.secondaryColor,
          screenFunction: () async {
            String userString= await MySharedPreferences.instance.getISLoggedIn();
            // bool isEmpty = await LocalStorageHelper.instance.isServerListEmpty();        
            if(userString==""){
            print(AppColor.primaryTextColor);
            // return VideoCall(data: "hsj");
            // final cameras = await availableCameras();
            // return  ChangeNotifierProvider(
            // create: (context) => VideoCallProvider(),
            // child: VideoCallSetupScreen(),
            // );
            return IntroPage();
            // return IntroPage();
            // return AdvocateAffidavitDetails(fileName: "Make a Will", isAffidavitPage: true,DocumentDetails: "");
            }
           //  User user= jsonDecode(userString);
           Map<String, dynamic> userMap = jsonDecode(userString);
           
            userClass = UserClass.fromJson(userMap);
           if(userClass.barRegistrationNo!="")
           return AdvocateDashboard(userclass: userClass);
           return  Dashboard(userclass: userClass);
          //  return StampPaper();
           // return AsyncLoader(username: "abc",meetingId: "123");
          },
        ),
      ),
    );
  }
}
