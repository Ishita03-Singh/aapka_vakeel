import 'package:aapka_vakeel/model/AdvocateCall.dart';
import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:video_call/video_call.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(height: 30),
          //  TextField(
          //       decoration: MyTextField.outlinedTextField(""),
          //       keyboardType: TextInputType.text,
          //       controller: ipController,
          //       // readOnly: true,
          //       //  validator: (value) {
          //       //     if (value == null || value.isEmpty) {
          //       //       return 'Please enter your name';
          //       //     }
          //       //     return null;
          //       //   },
          //       enabled: true,
          //       enableInteractiveSelection: false,
          //       cursorColor: AppColor.primaryTextColor,
          //       style: TextStyle(
          //           color: AppColor.primaryTextColor,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w400)),
          //           SizedBox(height: 20,),
          //           customButton.taskButton("save ip",(){
          //             MySharedPreferences.instance.setIp(ipController.text);
          //            Navigator.pop(context);
          //           }),
          //           SizedBox(height: 20),

           CustomText.RegularDarkText("Your Scheduled Calls"),

                    //scheduled calls here compare time in local data store regarding call and now time then enable

                    Container(
                       padding: EdgeInsets.only(top: 20),
                       width: MediaQuery.of(context).size.width-40,
                      height: MediaQuery.of(context).size.height-300,
                      child: ListView.builder(
                                  itemCount: userClass.advoacateCalls!.length,
                                  itemBuilder: (context, index) {
                                     AdvocateCall advocatecall = userClass.advoacateCalls![index];
                                    return  
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                CustomText.RegularDarkText("Your Call with ${advocatecall.advocateName}"),
                                                            
                                                                DateTime.now().toString()!=advocatecall.callTime?
                                                                customButton.smalltaskButton("Join Now", (){
                                                                    Navigator.of(context).pushReplacement(
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>JoinScreen(username: userClass.displayName,meetingId: userClass.uid,)
                                                                      // VideoCall(data: snapshot.data!),
                                                                    ),
                                                                );
                                                                }):customButton.cancelButton("Join at ${advocatecall.callTime}", (){})
                                                              ],
                                                            ),
                                    );
                                  },
                                ),
                    ),
                    
        ],),
      ),
    );
  }
}