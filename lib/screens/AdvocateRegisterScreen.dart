import 'dart:io';

import 'package:aapka_vakeel/screens/CaptureImage.dart';
import 'package:aapka_vakeel/screens/DashboardScreen.dart';
import 'package:aapka_vakeel/screens/phoneNumber_page.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class UserRegistrationForm extends StatefulWidget {
  bool isAdvocate = false;
  UserRegistrationForm({super.key, required this.isAdvocate});

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

enum Gender { Male, Female, Others }

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController EmailController = new TextEditingController();
  TextEditingController GenderController = new TextEditingController();
  TextEditingController AddressController = new TextEditingController();
  TextEditingController StateController = new TextEditingController();
  TextEditingController CityController = new TextEditingController();
  TextEditingController PinCodeController = new TextEditingController();
  TextEditingController BarRegistrationNoController =
      new TextEditingController();
  TextEditingController BarRegistrationCertificateController =
      new TextEditingController();
  Gender? _selectedGender;
  File? _selectedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: MyAppBar.appbar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              giveInputField("First name", firstNameController, true),
              giveInputField("Last name", lastNameController, true),
              giveInputField("Email", EmailController, false),
              giveRadioField("Gender", GenderController, true),
              giveInputField("Address", AddressController, true),
              giveInputField("State", StateController, true),
              giveInputField("City", CityController, true),
              giveInputField("Pin code", PinCodeController, true),
              if (widget.isAdvocate)
                giveInputField("Bar registration number",
                    BarRegistrationNoController, true),
              giveFileBrowseInputField("Bar registration Certificate",
                  BarRegistrationCertificateController, true),
              customButton.taskButton("Save", () {
                if (widget.isAdvocate) {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: CaptureImage(),
                          type: PageTransitionType.rightToLeft));
                } else {
                  //  Navigator.push(
                  //   context,
                  //   PageTransition(
                  //       child: DashboardScreen(),
                  //       type: PageTransitionType.rightToLeft));
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  giveFileBrowseInputField(
      String HeadText, TextEditingController controller, bool isrequired) {
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
            margin: EdgeInsets.fromLTRB(50, 30, 50, 30),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/upload.png',
                  height: 24,
                ),
                CustomText.infoText('PDF format upto 50 MB.', isCenter: true),
                Padding(padding: EdgeInsets.all(8)),
                customButton.smalltaskButton(
                    _selectedFile != null ? 'Change' : 'Browse', _pickFile),
                if (_selectedFile != null)
                  CustomText.infoText(_selectedFile!.path.split('/').last,
                      isCenter: true),
              ],
            ),
          ),
          //  ${_selectedFile!.path
        ],
      ),
    );
  }

  giveRadioField(
      String HeadText, TextEditingController controller, bool isrequired) {
    return Container(
      // padding: EdgeInsets.only(bottom: 20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<Gender>(
                    fillColor: MaterialStateProperty.all(Colors.black),
                    value: Gender.Male,
                    groupValue: _selectedGender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Male'),
                ],
              ),
              Row(
                children: [
                  Radio<Gender>(
                    fillColor: MaterialStateProperty.all(Colors.black),
                    value: Gender.Female,
                    groupValue: _selectedGender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Female'),
                ],
              ),
              Row(
                children: [
                  Radio<Gender>(
                    fillColor: MaterialStateProperty.all(Colors.black),
                    value: Gender.Others,
                    groupValue: _selectedGender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Others'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  giveInputField(
      String HeadText, TextEditingController controller, bool isrequired) {
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
          TextField(
              decoration: MyTextField.outlinedTextField(""),
              keyboardType: TextInputType.phone,
              controller: controller,
              // readOnly: true,
              enabled: true,
              enableInteractiveSelection: false,
              cursorColor: AppColor.primaryTextColor,
              style: TextStyle(
                  color: AppColor.primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
