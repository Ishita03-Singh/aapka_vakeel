import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController ipController= TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar.appbar(context),
      body
      : Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
           TextField(
                decoration: MyTextField.outlinedTextField(""),
                keyboardType: TextInputType.text,
                controller: ipController,
                // readOnly: true,
                //  validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your name';
                //     }
                //     return null;
                //   },
                enabled: true,
                enableInteractiveSelection: false,
                cursorColor: AppColor.primaryTextColor,
                style: TextStyle(
                    color: AppColor.primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
                    SizedBox(height: 20,),
                    customButton.taskButton("save ip",(){
                      MySharedPreferences.instance.setIp(ipController.text);
                     Navigator.pop(context);
                    }),
        ],),
      ),
    );
  }
}