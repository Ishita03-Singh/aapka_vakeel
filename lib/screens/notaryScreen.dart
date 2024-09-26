import 'dart:io';

import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/screens/asyncLoader.dart';
// import 'package:aapka_vakeel/screens/videoCall.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/cutom_message.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:html' as html;

class NotaryScreen extends StatefulWidget {
  String filePath;
   NotaryScreen({super.key,required this.filePath});

  @override
  State<NotaryScreen> createState() => _NotaryScreenState();
}

class _NotaryScreenState extends State<NotaryScreen> {
  File? adharCard;
  File? otherId;

  Future<void> _pickAdharFile() async {
    if(kIsWeb){
 html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  uploadInput.accept = '.pdf'; // Allow only PDF files
  uploadInput.click(); // Trigger the file picker

  uploadInput.onChange.listen((e) {
    final files = uploadInput.files;
    if (files != null && files.isNotEmpty) {
      final file = files.first;
        adharCard = File(file.name);
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((e) {
        setState(() {
          Uint8List fileBytes = reader.result as Uint8List;
            adharCard = File(file.name);
          // You can now use `fileBytes` as the PDF file data
        });
      });
    }
  });
    }
    else{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        adharCard = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
    }
  
  }

   Future<void> _pickFile() async {
    if(kIsWeb){
html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  uploadInput.accept = '.pdf'; // Allow only PDF files
  uploadInput.click(); // Trigger the file picker

  uploadInput.onChange.listen((e) {
    final files = uploadInput.files;
    if (files != null && files.isNotEmpty) {
      final file = files.first;
        otherId = File(file.name);
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((e) {
        setState(() {
          Uint8List fileBytes = reader.result as Uint8List;
            otherId = File(file.name);
          // You can now use `fileBytes` as the PDF file data
        });
      });
    }
  });
    }
    else{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        otherId = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
    }
  
  }
  
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(12,50,12,12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[ 
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top:12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                CustomText.headText("Notary"),
                SizedBox(height: 12),
                CustomText.boldinfoText("Upload Documents"),
                SizedBox(height: 12),
                CustomText.cancelBtnText("*Aadhar Card"),
                SizedBox(height: 8),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(25),
                    width: MediaQuery.of(context).size.width/1.3,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(
                    color: Colors.grey, // Set the border color here
                    width: 1.0, // Set the border width here
                  ),),
                    child: Column(children: [
                      Image.asset(StrLiteral.upload),
                      CustomText.extraSmallinfoText('PDF format upto 50 MB.'),
                      customButton.smalltaskButton(
                    adharCard != null ? 'Change' : 'Browse', (){
                      _pickAdharFile();
                    }),
                if (adharCard != null)
                  CustomText.infoText(adharCard!.path.split('/').last,
                      isCenter: true),
                    ],),
                  ),
                ),
                SizedBox(height: 8),
                CustomText.cancelBtnText("Pan Card/Passport/Voter ID"),
                SizedBox(height: 8),
                  Center(
                    child: Container(
                    padding: EdgeInsets.all(25),
                    width: MediaQuery.of(context).size.width/1.3,
                     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(
                    color: Colors.grey, // Set the border color here
                    width: 1.0, // Set the border width here
                                    ),),
                    child: Column(children: [
                      Image.asset(StrLiteral.upload),
                      CustomText.extraSmallinfoText('PDF format upto 50 MB.'),
                    customButton.smalltaskButton(
                    otherId != null ? 'Change' : 'Browse', (){
                      _pickFile();
                    }),
                       if (otherId != null)
                        CustomText.infoText(otherId!.path.split('/').last,
                      isCenter: true),
                    ],),
                                    ),
                  ),
                        
                        ],),
              ),
            ),
          customButton.taskButton("Save", (){
            if( adharCard == null){
            CustomMessenger.defaultMessenger(context, "Please select adhar");
            return false;
           }
          //   if( otherId == null){
          //   CustomMessenger.defaultMessenger(context, "Please select other Id as well");
          //   return false;
          //  }
           else{
            //upload files to cloud  
  Navigator.push(
                        context,
                        PageTransition(
                            child: AsyncLoader(username:userClass.displayName,meetingId:userClass.uid),
                            type: PageTransitionType.rightToLeft));
        //  loaderfunction();
           }
          })
          ]
        ),
      ),
    );
  }


 
}




class WaitingArea extends StatefulWidget {
  const WaitingArea({super.key});

  @override
  State<WaitingArea> createState() => _WaitingAreaState();
}

class _WaitingAreaState extends State<WaitingArea> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: [
         Container(
          padding: EdgeInsets.fromLTRB(12,50,12,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[ 
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top:12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  CustomText.headText("Notary"),
                  SizedBox(height: 12),
                  CustomText.boldinfoText("Waiting Area"),
                  SizedBox(height: 23),
                  CustomText.boldDarkText("Wait for some time.\n\nOur executive is busy and will \nreach in a bit."),
                  SizedBox(height: 8),
           ],),
                ),
              ),
             Image.asset(StrLiteral.wait)
            ]
          ),
        ),
         Center(
            child: Visibility(
              visible: _isLoading,
              child: LoadingAnimationWidget.hexagonDots(
                color: Color(0xFF9999999),
                size: 60,
              ),
            ),
          ),
          ]
      ),
    );
  }
}