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
import 'package:aapka_vakeel/utilities/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';

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
    TextEditingController countryController = new TextEditingController();
  TextEditingController PinCodeController = new TextEditingController();
    TextEditingController IntroController = new TextEditingController();
      TextEditingController ChargeController = new TextEditingController();
        TextEditingController ExperienceController = new TextEditingController();
          TextEditingController SkillsController = new TextEditingController();
          TextEditingController casesController= new TextEditingController();
  TextEditingController BarRegistrationNoController =
      new TextEditingController();
  TextEditingController BarRegistrationCertificateController =
      new TextEditingController();
   bool _isLoaderVisible = false;
  Gender? _selectedGender;
  File? _selectedFile;
  final _formKey = GlobalKey<FormState>();
    bool _isLoading = false;
  File barCertificateFile=File("path");
   final List<String> list = ["1-2 years","2-3 years", "3-5 years", "5-7 years","7-10 years","10-15 years","15-20 Years","20-25 years","25-30 Years"];
  // Selected item
 String dropdownValue ="1-2 years";
  
  var charges={
  "1-2 years":18,
  "2-3 years":23, 
  "3-5 years":29,
  "5-7 years":49,
  "7-10 years":59,
  "10-15 years":79,
  "15-20 Years":110,
  "20-25 years":145,
  "25-30 Years": 185
  };


//   .⁠ ⁠Experience of 1-2 years can not charge above Rs. 18/Minute
// 2.⁠ ⁠Experience of 2-3 years can not charge above Rs. 23/Minute
// 3.⁠ ⁠Experience of 3-5 years can not charge above Rs. 29/Minute
// 4.⁠ ⁠Experience of 5-7 years can not charge above Rs. 49/Minute
// 5.⁠ ⁠Experience of 7-10 years can not charge above Rs. 59/ Minute
// 6.⁠ ⁠Experience of 10-15 years can not charge above Rs. 79/Minute
// 7.⁠ ⁠Experience of 15-20 Years can not charge above Rs. 110/ Minute
// 8.⁠ ⁠Experience of 20-25 years can not charge above Rs. 145/Minute
// 9.⁠ ⁠Experience of 25-30 Years can not charge above  Rs. 185/Minute



  Future<bool> _register() async {


    print(_selectedGender);
    if (_formKey.currentState!.validate()) {
      try {
        if(_selectedGender==null){
           CustomMessenger.defaultMessenger(context, "Please select gender");
           return false;
           }
         setState(() {
                        _isLoading=true;
                      });
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
          'gender':_selectedGender.toString().split('.').last,
          'address':"${AddressController.text}, ${CityController.text}, ${StateController.text}, ${countryController.text}, ${PinCodeController.text}"
          // 'city':CityController.text,
          // 'pinCode':PinCodeController.text,
        });
        }
       
        else{
           

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
          'gender':_selectedGender.toString().split('.').last,
          'address':"${AddressController.text}, ${CityController.text}, ${StateController.text}, ${countryController.text}, ${PinCodeController.text}",
          // 'address':AddressController.text,
          // 'state':StateController.text,
          // 'city':CityController.text,
          // 'pinCode':PinCodeController.text,
          'barRegistrationNo':BarRegistrationNoController.text,
          'barRegistrationCertificate':barCertificateFile.path,
           'introduction':IntroController.text,
           'experience':ExperienceController.text,
           'charges':ChargeController.text,
           'skills':SkillsController.text,
           'typeofcases':casesController.text
        });
        }
        userClass.uid=widget.userCredential.user!.uid;
        userClass.email=EmailController.text;
        userClass.displayName=firstNameController.text +" "+ lastNameController.text;
        userClass.address="${AddressController.text}, ${CityController.text}, ${StateController.text}, ${countryController.text}, ${PinCodeController.text}";
        userClass.gender=_selectedGender.toString().split('.').last;
        userClass.barRegistrationNo= BarRegistrationNoController.text??"";
        userClass.barRegistrationCertificate=BarRegistrationCertificateController.text??"";
        userClass.phoneNumber= widget.userCredential.user!.phoneNumber!;
        userClass.introduction=IntroController.text??"";
        userClass.experience=ExperienceController.text??"";
        userClass.charges=ChargeController.text??"";
        userClass.skills=SkillsController.text??"";
        
        
        // Navigate to another page or show success message
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration successful')));
        // CustomMessenger.defaultMessenger(context, "Registration successful");
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
  void initState() {
    super.initState();
    ChargeController.text= charges[dropdownValue].toString();
    countryController.text= 'India';
  }
  
  Future<bool> requestLocationPermission() async {
  // Check if location permission is granted
  var status = await Permission.location.status;
  
  if (status.isDenied) {
    // Request location permission
    status = await Permission.location.request();
    
    if (status.isGranted) {
      // Permission granted, get the location
      return true;
    
    } else if (status.isPermanentlyDenied) {
      return false;
      
    }
  } else if (status.isGranted) {
    return true;
  }
  return false;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: MyAppBar.appbar(context),
      body: Stack(
        children:[ SingleChildScrollView(
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
                              
                  customButton.cancelButton("Get location", () async {
          bool permission = await requestLocationPermission();
          if (permission) {
            context.loaderOverlay.show();
            setState(() {
        _isLoaderVisible = context.loaderOverlay.visible;
            });
            
            try {
        // Check if location services are enabled
        bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!isLocationServiceEnabled) {
          CustomMessenger.defaultMessenger(context, "Location services are disabled. Please enable them.");
          await Geolocator.openLocationSettings();
          return; // Exit the function if location services are disabled
        }
        
        var location = await LocationService.getCityAndState();
        setState(() {
          CityController.text = location['city'] ?? '';
          StateController.text = location['state'] ?? '';
          PinCodeController.text= location['pincode']??'';
        });
            } catch (e) {
        print("Error: $e");
            } finally {
        if (_isLoaderVisible && context.mounted) {
          context.loaderOverlay.hide();
        } else {
          CustomMessenger.defaultMessenger(context, "Did not get Permission");
        }
            }
        
            setState(() {
        _isLoaderVisible = context.loaderOverlay.visible;
            });
          } else {
            CustomMessenger.defaultMessenger(context, "Location permission not granted.");
          }
        },color: Color(0xFFE0E1DD)),
        
                   SizedBox(height: 8),
                   getStateCityInput(),
                   
                    giveInputField("Address", AddressController, true,TextInputType.streetAddress),
                    // giveInputField("State", StateController, true,TextInputType.text),
                    // giveInputField("City", CityController, true,TextInputType.text),
                    giveInputField("Pin code", PinCodeController, true,TextInputType.number),
                    if (widget.isAdvocate)
                      giveInputField("Please give a short introduction",
                          IntroController, true,TextInputType.text),
                          if (widget.isAdvocate)
                          CustomText.infoText("Experience"),
                          if (widget.isAdvocate)
                      // giveInputField("Experience",
                      //     ExperienceController, true,TextInputType.number),
                      DropdownMenu<String>(
                        width: MediaQuery.of(context).size.width,
                          initialSelection: list.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            
                            setState(() {
                              dropdownValue = value!;
                              ChargeController.text= charges[dropdownValue].toString();
                            });
                          },
                          dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(value: value, label: value);
                          }).toList(),
                        ),
                          if (widget.isAdvocate)
                      giveInputField("Skills",
                          SkillsController, true,TextInputType.text),
                            if (widget.isAdvocate)
                      giveInputField("Type of cases",
                          casesController, true,TextInputType.text),
                          if (widget.isAdvocate)
                        giveInputField("Charges per minute",
                            ChargeController, true,TextInputType.number,tooltipText:charges.toString(),disable: true),
                         
                           
                          
                             
                    if (widget.isAdvocate)
                      giveInputField("Bar registration number",
                          BarRegistrationNoController, true,TextInputType.text),
                    if (widget.isAdvocate)
                    giveFileBrowseInputField("Bar registration Certificate",
                        BarRegistrationCertificateController, true),
                    customButton.taskButton("Save", () async{
                      if (widget.isAdvocate) {
                       
                        var res= await  _register();
                        setState(() {
                        _isLoading=false;
                      });
                        if(res){
                        Navigator.push(
                            context,
                            PageTransition(
                                child: CaptureImage(user:widget.userCredential.user! ,),
                                type: PageTransitionType.rightToLeft));
                        }
                        
                      } else {
                        var res= await _register();
                        setState(() {
                        _isLoading=false;
                      });
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
          if (_isLoading)
          ModalBarrier(
            color: Colors.grey.withOpacity(0.1),
            dismissible: false,
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
                border: Border.all(color: Color(0xFF0D1B2A)),
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


// ValidateFun(value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter ${HeadText}';
//                   }
//                   return null;}
  giveInputField(
      String HeadText, TextEditingController controller, bool isrequired, TextInputType textInputType,{tooltipText="",disable=false}) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
              if (isrequired)
                Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                ),
              Padding(padding: EdgeInsets.all(4)),
              CustomText.infoText(HeadText),
              ],),
             
              if(tooltipText!="")
                IconButton(
            icon: Icon(Icons.info_outline_rounded,color:Colors.grey ,size: 20,),
            tooltip: tooltipText,
            onPressed: () {},
          ) //IconButton
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
                readOnly: disable,
                
                 validator: (value){
                 validationService.validate(value!,textInputType);
            
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

  getStateCityInput(){
    return   CSCPicker(
                  // disableCountry:true,
                  defaultCountry:CscCountry.India,
                  currentCountry: CscCountry.India.toString(),
                  showCities: true,
                  showStates: true,
                   dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border:
                      Border.all(color: Colors.grey.shade300, width: 1)),

                  ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.shade300,
                      border:
                      Border.all(color: Colors.grey.shade300, width: 1)),
                  stateSearchPlaceholder: "State",
                  citySearchPlaceholder: "City",
                  stateDropdownLabel: "State",
                  cityDropdownLabel: "City",
                
                  selectedItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  dropdownHeadingStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),

                  dropdownItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  ///Dialog box radius [OPTIONAL PARAMETER]
                  dropdownDialogRadius: 10.0,

                  onCountryChanged: (value) {
                    setState(() {
                      ///store value in state variable
                      // var t=value.split('   ');
                      // print("part:"+t.toString()+" ");
                      countryController.text = value.split('    ')[1]??'';
                      // print(countryController.text);
                    });
                  },
                  ///Search bar radius [OPTIONAL PARAMETER]
                  searchBarRadius: 10.0,
                  onStateChanged: (value) {
                    setState(() {
                      ///store value in state variable
                      StateController.text = value??'';
                    });
                  },
                  ///triggers once city selected in dropdown
                  onCityChanged: (value) {
                    setState(() {
                      ///store value in city variable
                      CityController.text = value??'';
                    });
                  },
                );

  }
}
