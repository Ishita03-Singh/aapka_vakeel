import 'package:aapka_vakeel/screens/AdvocateRegisterScreen.dart';
import 'package:aapka_vakeel/screens/Dashboard.dart';
import 'package:aapka_vakeel/screens/DashboardScreen.dart';
import 'package:aapka_vakeel/screens/IntroScreen.dart';
import 'package:aapka_vakeel/screens/phoneNumber_page.dart';
import 'package:aapka_vakeel/screens/CatgoryScreen.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/firebasedemo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyAELVWJ4VVYcnb_1FBpVY4GPBtXWVtsu0M',
    appId: 'id',
    messagingSenderId: 'sendid',
    projectId: 'appkavakeel',
    storageBucket: 'appkavakeel.appspot.com',
  ));
   FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  await AppColor.setCurrentTheme();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: AppColor.bgColor,
        systemNavigationBarColor: AppColor.bgColor);
    return MaterialApp(
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
          // bool isEmpty = await LocalStorageHelper.instance.isServerListEmpty();
          // if (isEmpty) {
          print(AppColor.primaryTextColor);
          return Dashboard();
          // return IntroPage();
          // }

          // return const SelectServer();
        },
      ),
    );
  }
}
