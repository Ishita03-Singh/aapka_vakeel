import 'package:aapka_vakeel/model/AdvocateCall.dart';
import 'package:aapka_vakeel/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utilities/colors.dart';
import 'dart:convert';
class MySharedPreferences {
  MySharedPreferences();
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
      MySharedPreferences._privateConstructor();


void setISLoggedIn(UserClass user) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString('LOGGED_USER',  jsonEncode(user.toJson()));
  }
  void RemoveUserLoggedIn() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString('LOGGED_USER', "");
  }
Future<String> getISLoggedIn() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString('LOGGED_USER') ?? "";
  }

  void setAdvocateCallList(List<String> advocateCall) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList('AdvocateCallList', advocateCall);
  }
Future<List<String>> getdvocateCallList() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getStringList('AdvocateCallList') ?? [];
  }
   void setUserDownloadedFiles(List<String> docList) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList('DownloadedDocList', docList);
  }
Future<List<String>> getUserDownloadedFiles() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getStringList('DownloadedDocList') ?? [];
  }



  // void setTheme(String themeName) async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   myPrefs.setString('Theme', themeName);
  // }

  // Future<String> getTheme() async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   return myPrefs.getString('Theme') ?? Themes.blueLight.name;
  // }


  setAlertEnable(bool isAlertEnable) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool('_isAlertEnable', isAlertEnable);
  }

  Future<bool> getAlertEnable() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool('_isAlertEnable') ?? false;
  }





  enableAlertNotification(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("AlertNotification", value);
  }

  Future<bool> alertNotificationState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("AlertNotification") ?? false;
  }




  
  // setRtpEnable(bool isDdnsEnable) async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   myPrefs.setBool('_isRTPEnable', isDdnsEnable);
  // }

  // Future<bool> getRtpEnable() async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   return myPrefs.getBool('_isRTPEnable') ?? DefaultValues.isRtpEnable;
  // }
  // setNotificationEnable(bool value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool("_isNotificationEnable", value);
  // }

  // Future<bool> getNotificationEnable() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool("_isNotificationEnable") ??
  //       DefaultValues.isNotificationEnable;
  // }

  setIp(String ip) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString('IP', ip);
  }

  Future<String> getIP() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString('IP') ?? "";
  }


  setDefaultView(bool defaultView) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool('_defaultView', defaultView);
  }

  Future<bool> getDefaultView() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool('_defaultView') ?? true;
  }

  setDeviceUniqueId(String deviceid) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString('DEVICE_ID', deviceid);
  }

  Future<String> getDeviceUniqueId() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString('DEVICE_ID') ?? "";
  }

  void setTheme(String themeName) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString('Theme', themeName);
  }

  Future<String> getTheme() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString('Theme') ?? Themes.blueDark.name;
  }
}
