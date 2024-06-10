import 'package:aapka_vakeel/screens/DashboardScreen.dart';
import 'package:aapka_vakeel/screens/phoneNumber_page.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:page_transition/page_transition.dart';
import 'package:image_picker/image_picker.dart';

class CaptureImage extends StatefulWidget {
  const CaptureImage({super.key});

  @override
  State<CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
  File? _image;

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
              var xfile = await PickImage.pickImage(ImageSource.camera);
              setState(() {
                _image = File(xfile.path);
              });
              // _image = File(xfile.path);
              if (_image != null) {
                Navigator.push(
                    context,
                    PageTransition(
                        child: PreviewImage(image: _image),
                        type: PageTransitionType.rightToLeft));
              }
            })
          ]),
        ));
  }
}

class PreviewImage extends StatefulWidget {
  var image;
  PreviewImage({super.key, required this.image});

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
                child: Image.file(widget.image!, height: 250)),
            customButton.taskButton("Retake", () async {
              var xfile = await PickImage.pickImage(ImageSource.camera);
              setState(() {
                widget.image = File(xfile.path);
              });
            }),
            Padding(padding: EdgeInsets.all(4)),
            customButton.taskButton("Save", () {
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         child: DashboardScreen(user: user,),
              //         type: PageTransitionType.rightToLeft));
            }),
            Padding(padding: EdgeInsets.all(4)),
            Padding(padding: EdgeInsets.all(4)),
            CustomText.infoText(
                "*Your photo will only be used for identification purposes within the app and will not be shared with third parties.")
          ]),
        ));
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
