import 'dart:convert';
import 'dart:io';

import 'package:aapka_vakeel/model/AdvocateCall.dart';
import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/cutom_message.dart';
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
  List<AdvocateCall> advocateCall= [];
  List<String> downloadedDocList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdvocateCallList();
    

  }
  getAdvocateCallList()async{
   List<String> advocateCallListString= await  MySharedPreferences.instance.getdvocateCallList();
   advocateCallListString.forEach((call) {
    advocateCall.add(AdvocateCall.fromJson(jsonDecode(call)));
  });

  downloadedDocList= await MySharedPreferences.instance.getUserDownloadedFiles();
  setState(() {
    
  });
     
   
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar.appbar(context),
      body
      : Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            CustomText.boldDarkText("Your Scheduled Calls"),
            getAdvocateCallListWidget(),
            CustomText.boldDarkText("Your Past Downloads"),
            getPastDownloadsWidget(),
          
                      
          ],),
        ),
      ),
    );
  }

  getPastDownloadsWidget(){
    return  Container(
                       padding: EdgeInsets.only(top: 20),
                      child: downloadedDocList.length==0?CustomText.infoText("No downloads yet"):ListView.builder(
                                  shrinkWrap: true, // Ensures ListView takes only the needed height
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: downloadedDocList.length,
                                  itemBuilder: (context, index) {
                                     String stringContent = downloadedDocList[index];
                                     File file= File(stringContent);
                                    return  
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Color(0xFFE0E1DD),
                                      ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Column(children: [
                                                                    CustomText.RegularDarkText(file.path.split('/')[5]),
                                                                ],),
                                                                
                                                              
                                                                customButton.smalltaskButton("Download", ()async{
                                                                  await  downloadSavedFile(file);
                                                                })
                                                               
                                                              ],
                                                            ),
                                    );
                                  },
                                ),
                    );
  }

  Future<File?> getFileFromSavedPath(File file) async {
  try {

      if (file.existsSync()) {
        return file;
      } else {
        print("File does not exist at ${file.path}");
        return null;
      }
    
  } catch (ex) {
    print("Error retrieving file: $ex");
    return null;
  }
}
Future<void> downloadSavedFile(File savedFile) async {
  final file = await getFileFromSavedPath(savedFile);
  if (file != null) {

    // Notify the user that the file is ready for download
    print("File is ready for download: ${file.path}");
    CustomMessenger.defaultMessenger(context, 'File is downloaded at : ${file.path}');

    // Example: Open the file or trigger a download action
    // You could implement platform-specific actions here, such as using
    // Android's Intent or sharing functionality.
  } else {
    print("No file available to download.");
     CustomMessenger.defaultMessenger(context, 'Error finding File');
  }
}


  getAdvocateCallListWidget(){
    return  Container(
                       padding: EdgeInsets.only(top: 20),
                      child: advocateCall!.length==0?CustomText.infoText("No calls yet"): ListView.builder(
                                  shrinkWrap: true, // Ensures ListView takes only the needed height
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: advocateCall!.length,
                                  itemBuilder: (context, index) {
                                     AdvocateCall advocatecall = advocateCall![index];
                                       DateTime dateTime = DateTime.parse(advocatecall.callTime);
                                       var t=DateTime.now();
                                    return  
                                    Container(
                                       decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Color(0xFFE0E1DD),
                                      ),
                                    padding: const EdgeInsets.all(8.0),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Column(children: [
                                                                    CustomText.RegularDarkText("Your Call with ${advocatecall.advocateName}"),
                                                                ],),
                                                                
                                                                
                                                                t!=dateTime?
                                                                customButton.smalltaskButton("Join Now", (){
                                                                    Navigator.of(context).pushReplacement(
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>JoinScreen(username: userClass.displayName,meetingId:advocatecall.advoacteId,isJoin: true,)
                                                                      // VideoCall(data: snapshot.data!),
                                                                    ),
                                                                );
                                                                }):
                                                                Column(children: [
                                                                   CustomText.infoText("Join at ${advocatecall.callTime.split(' ')[0]}",),
                                                                    CustomText.infoText("${advocatecall.callTime.split(' ')[1]}",)
                                                                ],)
                                                               
                                                              ],
                                                            ),
                                    );
                                  },
                                ),
                    );
  }
}

