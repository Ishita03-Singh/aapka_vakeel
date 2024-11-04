import 'dart:convert';

import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/pushNotificationService.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/screens/AdvocateRegisterScreen.dart';
import 'package:aapka_vakeel/screens/Dashboard.dart';
import 'package:aapka_vakeel/screens/DashboardScreen.dart';
import 'package:aapka_vakeel/screens/IntroScreen.dart';
import 'package:aapka_vakeel/screens/advocate/AdvocateDashboard.dart';
import 'package:aapka_vakeel/screens/asyncLoader.dart';
import 'package:aapka_vakeel/screens/notaryScreen.dart';
import 'package:aapka_vakeel/screens/paymentGateway.dart';
import 'package:aapka_vakeel/screens/phoneNumber_page.dart';
import 'package:aapka_vakeel/screens/CatgoryScreen.dart';
import 'package:aapka_vakeel/screens/stampPaper.dart';
import 'package:aapka_vakeel/screens/videoCall.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:aapka_vakeel/web/PrivacyPolicy.dart';
import 'package:aapka_vakeel/web/TermsAndCondition.dart';
import 'package:aapka_vakeel/web/launchPage.dart';
import 'package:aapka_vakeel/web/webpage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  appId: "1:361879211179:web:f2a913289cda8cc0c3bbee",
  measurementId: "G-CV0KKNLDLS"
      
  ));
    // final fcmToken = await FirebaseMessaging.instance.getToken();
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
   FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    
  );
   String userString= await MySharedPreferences.instance.getISLoggedIn();
   UserClass? user;
      if(userString==""){
          print(AppColor.primaryTextColor);
          // return Webpage();
          }
          else{
             Map<String, dynamic> userMap = jsonDecode(userString);
         user = UserClass.fromJson(userMap);
          }
        
        //  return  Webpage(userclass: userClass);
 
  // FirebaseMessaging.onBackgroundMessage(PushNotificationService.backgroundHandler);
  await AppColor.setCurrentTheme();
  runApp( MyApp(user: user));
}

class MyApp extends StatelessWidget {
  // final PushNotificationService _notificationService = PushNotificationService();
  UserClass? user;

   MyApp({super.key,this.user});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  PushNotificationService.initialize();
    SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: AppColor.bgColor,
        systemNavigationBarColor: AppColor.bgColor);
      // String initialRoute = Webpage.routeName;
    return MaterialApp(
      title: StrLiteral.appName,
      debugShowCheckedModeBanner: false,
      // initialRoute: initialRoute,
    routes: <String, WidgetBuilder>{
      // Webpage.routeName: (_) =>Webpage(userclass: user),
      TermsAndCondition.routeName: (_) => TermsAndCondition()
    },

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

      home: 
      // Webpage(userclass: user),
      LaunchPage(),
      // AnimatedSplashScreen.withScreenFunction(
      //   duration: 1000,
      //   animationDuration: const Duration(milliseconds: 900),
      //   curve: Curves.easeInSine,
      //   splash: Image.asset(StrLiteral.appLogoPath),
      //   splashIconSize: 250,
      //   splashTransition: SplashTransition.scaleTransition,
      //   pageTransitionType: PageTransitionType.rightToLeftWithFade,
      //   backgroundColor: AppColor.secondaryColor,
      //   screenFunction: () async {
         
          // bool isEmpty = await LocalStorageHelper.instance.isServerListEmpty();        
       
        //  return StampPaper();
         // return AsyncLoader(username: "abc",meetingId: "123");
        // },
      // ),
    );
  }
}
