import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../utilities/colors.dart';
import '../utilities/custom_button.dart';
import '../utilities/custom_text.dart';
import '../utilities/my_appbar.dart';
import '../utilities/my_textfield.dart';
import '../utilities/strings.dart';
import '../utilities/validation.dart';

class TrafficChallan extends StatefulWidget {
  const TrafficChallan({super.key});

  @override
  State<TrafficChallan> createState() => _TrafficChallanState();
}

class _TrafficChallanState extends State<TrafficChallan> {

  TextEditingController vehicleNumberController =TextEditingController();
  TextEditingController vehicleOwnerController =TextEditingController();
  File? RCController ;
  File? adharCardController;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar.appbar(context,head: 'Fill challan'),
      body: SingleChildScrollView(
        child: Container(
        height: MediaQuery.of(context).size.height-100,
        padding: EdgeInsets.fromLTRB(12, 40, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          // CustomText.headText("E-Stamp Paper"),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            giveInputField("Vehicle number", vehicleNumberController, true,TextInputType.text),
            giveInputField("Name of Vehicle Owner", vehicleOwnerController, true,TextInputType.name),
            CustomText.cancelBtnText("* Upload Registration Certificate(RC) photo"),
                SizedBox(height: 8),
           getFileUpload(RCController,()async {
            var res= await  pickFile();
             setState(() {
              RCController=  res;
             });
           }),
           SizedBox(height: 10),
           CustomText.cancelBtnText("* Upload Aadhar Card"),
                SizedBox(height: 8),
            getFileUpload(adharCardController,()async {
               var res= await  pickFile();
             setState(() {
              adharCardController= res;
             });
           }),
          ])
          ,
          
          customButton.taskButton("Save and Continue", (){
            Navigator.pop(context);
          })
          ]
          ))
          ));
          
            
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
     
        var id = File(result.files.single.path!);
        return id;
      
    } else {
      return null;
      // User canceled the picker
    }
  }
  getFileUpload(File? file,Function fun ){
    return Center(
                  child: Container(
                    padding: EdgeInsets.all(25),
                    width: MediaQuery.of(context).size.width/1.1,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(
                    color: Colors.grey, // Set the border color here
                    width: 1.0, // Set the border width here
                  ),),
                    child: Column(children: [
                      Image.asset(StrLiteral.upload),
                      CustomText.extraSmallinfoText('PDF format upto 50 MB.'),
                      customButton.smalltaskButton(
                    file != null ? 'Change' : 'Browse', (){
                      fun();
                    }),
                if (file != null)
                  CustomText.infoText(file!.path.split('/').last,
                      isCenter: true),
                    ],),
                  ),
                );
  }
  giveInputField(
      String HeadText, TextEditingController controller, bool isrequired, TextInputType textInputType) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              if (isrequired)
                Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                ),
              Padding(padding: EdgeInsets.all(4)),
              CustomText.infoText(HeadText),
            ],
          ),
          Container(
             decoration: BoxDecoration(
                color: Colors.white, // Background color for the input
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7), // Shadow color
                    blurRadius: 6, // Spread of the shadow
                    offset: Offset(0, 3), // Position of the shadow
                  ),
                ],
              ),
            child: TextFormField(
                decoration: MyTextField.outlinedTextField(""),
                keyboardType: textInputType,
                controller: controller,
                // readOnly: true,
                 validator: (value) {
                  validationService.validate(value!, textInputType);
                    // if (value == null || value.isEmpty) {
                    //   return 'Please enter ${HeadText}';
                    // }
                    // return null;
                  },
                enabled: true,
                enableInteractiveSelection: false,
                cursorColor: AppColor.primaryTextColor,
                style: TextStyle(
                    color: AppColor.primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    );
  }
}