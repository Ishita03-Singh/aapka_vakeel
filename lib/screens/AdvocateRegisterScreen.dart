import 'dart:io';

import 'package:aapka_vakeel/HTTP/serverhttpHelper.dart';
import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/screens/CaptureImage.dart';
import 'package:aapka_vakeel/screens/Dashboard.dart';
import 'package:aapka_vakeel/screens/DashboardScreen.dart';
import 'package:aapka_vakeel/screens/phoneNumber_page.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/cutom_message.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';

import '../others/locationService.dart';
// import 'dart:html' as html;

class UserRegistrationForm extends StatefulWidget {
  bool isAdvocate = false;
  UserCredential userCredential;
  UserRegistrationForm({super.key, required this.isAdvocate,required this.userCredential});

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
    TextEditingController IntroController = new TextEditingController();
      TextEditingController ChargeController = new TextEditingController();
        TextEditingController ExperienceController = new TextEditingController();
          TextEditingController SkillsController = new TextEditingController();
  TextEditingController BarRegistrationNoController =
      new TextEditingController();
  TextEditingController BarRegistrationCertificateController =
      new TextEditingController();
   bool _isLoaderVisible = false;
  Gender? _selectedGender;
  File? _selectedFile;
  final _formKey = GlobalKey<FormState>();
  File barCertificateFile=File("path");

  Future<bool> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        // UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //   email: _emailController.text,
        //   password: _passwordController.text,
        // );

        // Save additional user data in Firestore
        if(!widget.isAdvocate){
          await FirebaseFirestore.instance.collection('users').doc(widget.userCredential.user!.uid).set({
          'phoneNumber':widget.userCredential.user!.phoneNumber,
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': EmailController.text,
          'gender':GenderController.text,
          'address':"${AddressController.text},${CityController.text},${StateController.text},${PinCodeController.text}"
          // 'city':CityController.text,
          // 'pinCode':PinCodeController.text,
        });
        }
       
        else{
           if(_selectedGender==null){
           CustomMessenger.defaultMessenger(context, "Please select gender");
           return false;
           }

           if( _selectedFile == null){
            CustomMessenger.defaultMessenger(context, "Please select a file");
            return false;
           }


          await Serverhttphelper.uploadFileWeb(barCertificateFile,"advocateBarCertificates",widget.userCredential.user!.phoneNumber!);

          // await Serverhttphelper.uploadFile(barCertificateFile,"advocateBarCertificates",userClass.phoneNumber);
           await FirebaseFirestore.instance.collection('advocates').doc(widget.userCredential.user!.uid).set({
          'phoneNumber':widget.userCredential.user!.phoneNumber,
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': EmailController.text,
          'gender':GenderController.text,
          'address':"${AddressController.text},${CityController.text},${StateController.text},${PinCodeController.text}",
          // 'address':AddressController.text,
          // 'state':StateController.text,
          // 'city':CityController.text,
          // 'pinCode':PinCodeController.text,
          'barRegistrationNo':BarRegistrationNoController.text,
          'barRegistrationCertificate':barCertificateFile.path,
           'introduction':IntroController.text,
           'experience':ExperienceController.text,
           'charges':ChargeController.text,
           'skills':SkillsController.text
        });
        }
        userClass.uid=widget.userCredential.user!.uid;
        userClass.email=EmailController.text;
        userClass.displayName=firstNameController.text +lastNameController.text;
        userClass.address="${AddressController.text},${CityController.text},${StateController.text},${PinCodeController.text}";
        userClass.barRegistrationNo= BarRegistrationNoController.text??"";
        userClass.barRegistrationCertificate=BarRegistrationCertificateController.text??"";
        userClass.phoneNumber= widget.userCredential.user!.phoneNumber!;
        userClass.introduction=IntroController.text??"";
        userClass.experience=ExperienceController.text??"";
        userClass.charges=ChargeController.text??"";
        userClass.skills=SkillsController.text??"";
        
        
        // Navigate to another page or show success message
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration successful')));
        CustomMessenger.defaultMessenger(context, "Registration successful");
        return true;

      } on FirebaseAuthException catch (e) {
        CustomMessenger.defaultMessenger(context, "Failed to register: $e");
        return false;
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to register: $e')));
      }
    }
    else{
      return false;
    }
  }
  

  Future<void> _pickFile() async {
    if(kIsWeb){
//  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//   uploadInput.accept = 'application/pdf,image/*'; // Allow only PDF files
//   uploadInput.click(); // Trigger the file picker

//   uploadInput.onChange.listen((e) {
//     final files = uploadInput.files;
//     if (files != null && files.isNotEmpty) {
//       barCertificateFile= files[0];
//       final file = files.first;
//         _selectedFile = File(file.name);
//       final reader = html.FileReader();
//       reader.readAsArrayBuffer(file);

//       reader.onLoadEnd.listen((e) {
//         setState(() {
//           Uint8List fileBytes = reader.result as Uint8List;
//             _selectedFile = File(file.name);
//           // You can now use `fileBytes` as the PDF file data
//         });
//       });
//     }
//   });
    }
    else{
FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        
        _selectedFile = File(result.files.single.path!);
        barCertificateFile= _selectedFile!;
      });
    } else {
      // User canceled the picker
    }
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
          child: Form(
              key: _formKey,
            child:
            
          // Stack(
          //   children: [
          //     if( isLoading)
          //      Center(child: CircularProgressIndicator()) ,
                Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  giveInputField("First name", firstNameController, true,TextInputType.name),
                  giveInputField("Last name", lastNameController, true,TextInputType.name),
                  giveInputField("Email", EmailController, false,TextInputType.emailAddress),
                  giveRadioField("Gender", GenderController, true),
                            
                  customButton.cancelButton("Get location",()async{
                 context.loaderOverlay.show();
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
                      try {
                        var location = await LocationService.getCityAndState();
                        setState(() {
                          CityController.text = location['city'] ?? '';
                          StateController.text = location['state'] ?? '';
                        });
                      } catch (e) {
                        // setState(() {
                        //   _city = 'Error';
                        //   _state = 'Error';
                        // });
                      }
                      finally{
                               if (_isLoaderVisible && context.mounted) {
                  context.loaderOverlay.hide();
                }
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });
                      }
                  
                  }),
                  giveInputField("Address", AddressController, true,TextInputType.streetAddress),
                  giveInputField("State", StateController, true,TextInputType.text),
                  giveInputField("City", CityController, true,TextInputType.text),
                  giveInputField("Pin code", PinCodeController, true,TextInputType.phone),
                  if (widget.isAdvocate)
                    giveInputField("Please give a short introduction",
                        IntroController, true,TextInputType.text),
                        if (widget.isAdvocate)
                    giveInputField("Experience",
                        ExperienceController, true,TextInputType.text),
                        if (widget.isAdvocate)
                    giveInputField("Skills",
                        SkillsController, true,TextInputType.text),
                        if (widget.isAdvocate)
                    giveInputField("Charges per minute",
                        ChargeController, true,TextInputType.text),
                  if (widget.isAdvocate)
                    giveInputField("Bar registration number",
                        BarRegistrationNoController, true,TextInputType.text),
                  if (widget.isAdvocate)
                  giveFileBrowseInputField("Bar registration Certificate",
                      BarRegistrationCertificateController, true),
                  customButton.taskButton("Save", () async{
                    if (widget.isAdvocate) {
                      var res= await  _register();
                      if(res){
                      Navigator.push(
                          context,
                          PageTransition(
                              child: CaptureImage(user:widget.userCredential.user! ,),
                              type: PageTransitionType.rightToLeft));
                      }
                      
                    } else {
                      var res= await _register();
                      if(res){
                         MySharedPreferences.instance.setISLoggedIn(userClass);
                         Navigator.push(
                        context,
                        PageTransition(
                            child: Dashboard(user: widget.userCredential.user!,userclass: userClass,),
                            type: PageTransitionType.rightToLeft));
                      }
                      
                    }
                  })
                ],
                              ),
         
            // ],
          ),
          ),
        ),
      );
    // );
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
          TextFormField(
              decoration: MyTextField.outlinedTextField(""),
              keyboardType: textInputType,
              controller: controller,
              // readOnly: true,
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ${HeadText}';
                  }
                  return null;
                },
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
