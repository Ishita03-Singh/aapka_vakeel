import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/screens/Dashboard.dart';
import 'package:aapka_vakeel/screens/DashboardScreen.dart';
import 'package:aapka_vakeel/screens/advocate/AdvocateDashboard.dart';
import 'package:aapka_vakeel/screens/phoneNumber_page.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:page_transition/page_transition.dart';
import 'package:image_picker/image_picker.dart';

// import 'dart:html' as html;

import '../HTTP/serverhttpHelper.dart';
class CaptureImage extends StatefulWidget {
  User user;
   CaptureImage({super.key,required this.user});

  @override
  State<CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
  File? _image;
  File? advocateImage=File("path");
  //  html.File advocateImage= html.File([], "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: MyAppBar.appbar(context),
        body: Container(
          padding: EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CustomText.headText("Face Capture"),
            Container(
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              padding: EdgeInsets.all(40),
              child: Image.asset(
                'assets/images/capture.png',
                height: 113,
              ),
            ),
            CustomText.infoText("Instructions :"),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            CustomText.infoText(
                "1. Stand in a well-lit area facing the camera."),
            CustomText.infoText(
                "2. Ensure your face is clearly visible and centered within the frame."),
            CustomText.infoText(
                "3. When ready, tap the 'Capture' button to take your photo."),
            Padding(
              padding: EdgeInsets.all(12),
            ),
            customButton.taskButton("Capture", () async {
          if(kIsWeb){
            _captureImageWeb();
          }
          else{
            var xfile = await PickImage.pickImage(ImageSource.camera);
                          setState(() {
                            _image = File(xfile.path);
                          });
                          // _image = File(xfile.path);
                          if (_image != null) {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: PreviewImage(image: _image,user: widget.user,advocateImage: advocateImage!,),
                                    type: PageTransitionType.rightToLeft));
              }
            } 
            
             
            })
          ]),
        ));
  }

  Future<void> _captureImageWeb() async {
  // Create a file picker input element for camera capture
  // html.FileUploal && files.isNotEmpty) {
  //     advocateImage=files[0];
  //     final file = files.first;

  //     // Read the selected file as data
  //     final reader = html.FileReader();
  //     reader.readAsArrayBuffer(file); // Read file as binary (Uint8List)

  //     reader.onLoadEnd.listen((e) {
  //       Uint8List imageData = reader.result as Uint8List; // Get image data
  //       setState(() {
  //         _image = File.fromRawPath(imageData); // Save image data
  //       });

  //       if (_image != null) {
  //         Navigator.push(
  //           context,
  //           PageTransition(
  //             child: PreviewImage(
  //               advocateImage:advocateImage,
  //               image: imageData, // Pass image data
  //               user: widget.user,
  //             ),
  //             type: dInputElement uploadInput = html.FileUploadInputElement();
  // uploadInput.accept = 'image/*'; // Allow only images
  // uploadInput.setAttribute('capture', 'camera'); 
  // uploadInput.click(); // Open the file picker (camera)

  // // Listen for changes (file selected)
  // uploadInput.onChange.listen((e) {
  //   final files = uploadInput.files;
  //   if (files != nulPageTransitionType.rightToLeft,
  //           ),
  //         );
  //       }
  //     });
  //   }
  // });
}
}


class PreviewImage extends StatefulWidget {
  // html.File advocateImage= html.File([], "");
  File advocateImage;
  User user;
  var image;
  PreviewImage({super.key, required this.image,required this.user, required this.advocateImage });

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {

    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: MyAppBar.appbar(context),
        body: Container(
          padding: EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CustomText.headText("Preview"),
            Container(
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                // padding: EdgeInsets.all(40),
                child: kIsWeb?Image.memory(widget.image!,height: 250) : Image.file(widget.image!, height: 250)),
            customButton.taskButton("Retake", () async {
              if(!kIsWeb)
              {
                var xfile = await PickImage.pickImage(ImageSource.camera);
                 setState(() {
                widget.image = File(xfile.path);
              });
              }
              else
              {
                _captureImageWeb();
              }
              
             
            }),
            Padding(padding: EdgeInsets.all(4)),
            customButton.taskButton("Save", () async{
            await Serverhttphelper.uploadFileWeb(widget.image,"AdvocateImages",widget.user.phoneNumber!);


              MySharedPreferences.instance.setISLoggedIn(userClass);
              Navigator.push(
                  context,
                  PageTransition(
                      child: AdvocateDashboard(user: widget.user,userclass: userClass,image:widget.image),
                      type: PageTransitionType.rightToLeft));
            }),
            Padding(padding: EdgeInsets.all(4)),
            Padding(padding: EdgeInsets.all(4)),
            CustomText.infoText(
                "*Your photo will only be used for identification purposes within the app and will not be shared with third parties.")
          ]),
        ));
  }
  Future<void> _captureImageWeb() async {
  // Create a file picker input element for camera capture
  // html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  // uploadInput.accept = 'image/*'; // Allow only images
  // uploadInput.setAttribute('capture', 'camera'); 
  // uploadInput.click(); // Open the file picker (camera)

  // // Listen for changes (file selected)
  // uploadInput.onChange.listen((e) {
  //   final files = uploadInput.files;
  //   if (files != null && files.isNotEmpty) {
  //     widget.advocateImage= files[0];
  //     final file = files.first;
  //     // Read the selected file as data
  //     final reader = html.FileReader();
  //     reader.readAsArrayBuffer(file); // Read file as binary (Uint8List)
  //     reader.onLoadEnd.listen((e) {
  //       Uint8List imageData = reader.result as Uint8List; // Get image data
  //       setState(() {
  //        widget.image = imageData; // Save image data
  //       });

  //     });
  //   }
  // });
}
}

class PickImage {
  static Future<XFile> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      // setState(() {
      //   _image = File(image.path);
      // });
    }
    return image!;
  }
}
