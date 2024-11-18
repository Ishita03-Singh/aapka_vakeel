import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/Audio%20Call/main.dart';
import 'package:aapka_vakeel/screens/AdvocateRegisterScreen.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/cutom_message.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
 final _formKey = GlobalKey<FormState>(); 
 TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController EmailController = new TextEditingController();
  TextEditingController GenderController = new TextEditingController();
  TextEditingController AddressController = new TextEditingController();
  TextEditingController phonenumberController = new TextEditingController();
 Gender? _selectedGender;


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController.text=userClass.displayName.split(' ')[0];
    lastNameController.text=userClass.displayName.split(' ')[1];
    EmailController.text=userClass.email;
    GenderController.text=userClass.gender;
    AddressController.text=userClass.address;
    phonenumberController.text= userClass.phoneNumber;
     Gender? gender = Gender.values.firstWhere(
    (e) => e.toString().split('.').last == userClass.gender,
    orElse: () => Gender.Others,
    );

  if (gender != null) {
     _selectedGender=gender;
  } else {
   _selectedGender =Gender.Male;
  }

    
  }

  Future<bool> _register() async {


    // print(_selectedGender);
    if (_formKey.currentState!.validate()) {
      try {
        // UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //   email: _emailController.text,
        //   password: _passwordController.text,
        // );

        // Save additional user data in Firestore
        // if(!widget.isAdvocate){
          await FirebaseFirestore.instance.collection('users').doc(userClass.uid).set({
          'phoneNumber':phonenumberController.text,
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': EmailController.text,
          'gender':_selectedGender.toString().split('.').last,
          'address':AddressController.text
          // 'city':CityController.text,
          // 'pinCode':PinCodeController.text,
        });
        // }
       
      
        
        userClass.uid=userClass.uid;
        userClass.email=EmailController.text;
        userClass.displayName=firstNameController.text +lastNameController.text;
        userClass.address=AddressController.text;
        userClass.gender=_selectedGender.toString().split('.').last;
        userClass.phoneNumber= phonenumberController.text;

        
        
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
 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar.appbar(context,head: "My Profile"),
      body:Container(
        padding: EdgeInsets.all(12),
        child:Form(
           key: _formKey,
          child: SingleChildScrollView(
            child: Column
            (crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            CustomText.boldDarkText("First name"),
            giveInputField("", firstNameController, true,TextInputType.text),
            CustomText.boldDarkText("Last name"),
             giveInputField("", lastNameController, true,TextInputType.text),
            CustomText.boldDarkText("Gender"),
            giveRadioField("Gender", GenderController, true),
            CustomText.boldDarkText("Email"),
            giveInputField("", EmailController, true,TextInputType.emailAddress),
            CustomText.boldDarkText("Phone number"),
            giveInputField("", phonenumberController, true,TextInputType.phone),
            CustomText.boldDarkText("Address"),
            giveInputField("", AddressController, true,TextInputType.streetAddress),
            
            customButton.taskButton("Update", ()async{
                        var res= await  _register();
                        if(res){
                          CustomMessenger.defaultMessenger(context, "User Updated successfully");
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         child: CaptureImage(user:widget.userCredential.user! ,),
                        //         type: PageTransitionType.rightToLeft));
                        
              }
              else
                          CustomMessenger.defaultMessenger(context, "Failed to update");
            
            
            })
            ],),
          ),

        )
      )
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