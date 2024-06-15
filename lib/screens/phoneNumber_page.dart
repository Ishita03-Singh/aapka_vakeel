import 'package:aapka_vakeel/main.dart';
import 'package:aapka_vakeel/screens/CatgoryScreen.dart';
import 'package:aapka_vakeel/screens/DashboardScreen.dart';
import 'package:aapka_vakeel/screens/OTPScreen.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/cutom_message.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import '../Utilities/strings.dart';
import 'package:country_picker/country_picker.dart';

class PhoneNumPage extends StatefulWidget {
  var first;
  bool isAdvocate;
  PhoneNumPage({super.key, required this.first, required this.isAdvocate});

  @override
  State<PhoneNumPage> createState() => _PhoneNumPageState();
}

class _PhoneNumPageState extends State<PhoneNumPage> {
  bool _isLoading = false;
  Country country = Country.worldWide;
  TextEditingController countryCodeController =
      TextEditingController(text: "+91 ");
  TextEditingController phonenumController = TextEditingController(text: "");
  TextEditingController countryController = TextEditingController();
  bool termsCond = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: MyAppBar.appbar(context),
        body: Stack(children: [
           
          SingleChildScrollView(
            child: Container(

              padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText.headText(
                      widget.first ? "Lets get started" : "Welcome Back!"),
                  // Padding(padding: EdgeInsets.all(12)),
                  CustomText.infoText(
                      "Lorem Ipsum is simply dummy text of the  printing and typesetting industry. Lorem Ipsm has been dummy text ever since the 1500s"),
                  Padding(padding: EdgeInsets.only(top: 12)),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70,
                          child: IntlPhoneField(
                            invalidNumberMessage: '',
                            disableLengthCheck: true,
                            pickerDialogStyle: PickerDialogStyle(width: 300),
                            flagsButtonPadding: const EdgeInsets.all(8),
                            dropdownIconPosition: IconPosition.trailing,
                            controller: countryController,
                            decoration: MyTextField.filledTextField(""),
                            dropdownIcon:
                                Icon(Icons.keyboard_arrow_down_rounded),
                            style: TextStyle(
                                color: AppColor.primaryTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            initialCountryCode: 'IN',
                            onCountryChanged: (value) {
                              countryCodeController.text =
                                  "+" + value.dialCode + " ";
                              setState(() {});
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 110,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 50,
                                child: TextField(
                                    decoration:
                                        MyTextField.filledTextFieldCountryCode(
                                            ""),
                                    keyboardType: TextInputType.phone,
                                    controller: countryCodeController,
                                    readOnly: true,
                                    // enabled: true,
                                    // enableInteractiveSelection: false,
                                    // cursorColor: AppColor.primaryTextColor,
                                    style: TextStyle(
                                        color: AppColor.primaryTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900)),
                              ),
                              Expanded(
                                child: Container(
                                  child: TextField(
                                      decoration: MyTextField.PhoneText(
                                          "Enter Phone Number"),
                                      keyboardType: TextInputType.phone,
                                      controller: phonenumController,
                                      // readOnly: true,
                                      enabled: true,
                                      enableInteractiveSelection: false,
                                      cursorColor: AppColor.primaryTextColor,
                                      style: TextStyle(
                                          color: AppColor.primaryTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.first)
                    Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.black,
                            useMaterial3: true),
                        child: ListTileTheme(
                          horizontalTitleGap: 0,
                          child: CheckboxListTile(
                            contentPadding: const EdgeInsets.all(0),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Row(
                              children: [
                                CustomText.infoText("I agree to the "),
                                Text("terms and conditions",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                        color: AppColor.primaryTextColor,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),

                            activeColor: AppColor.tertiaryColor,
                            // fillColor: MaterialStatePropertyAll(Color(0xffececec)),
                            checkColor: AppColor.tertiaryTextColor,
                            value: termsCond,
                            onChanged: (newValue) =>
                                setState(() => termsCond = newValue!),
                          ),
                        )),
                  Padding(padding: EdgeInsets.only(top: 12)),
                  customButton.taskButton("Continue", () {
                    if (phonenumController.text.isEmpty ||
                        phonenumController.text.length != 10) {
                      CustomMessenger.defaultMessenger(
                          context, "Please enter valid phone number");
                      return;
                    }
                    if(!termsCond && widget.first){
                       CustomMessenger.defaultMessenger(
                          context, "Please accept our terms and conditions");
                      return;   
                    }
                    setState(() {
                      _isLoading = true; // Start the task
                    });
                    final phone = countryCodeController.text.trim() +
                        phonenumController.text.trim();

                    loginUser(phone, context);
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         child: OTPScreen(),
                    //         type: PageTransitionType.rightToLeft));
                  }),
                  Padding(padding: EdgeInsets.all(8)),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (widget.first) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhoneNumPage(
                                        first: false,
                                        isAdvocate: false,
                                      )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()));
                        }
                      },
                      child: RichText(
                          text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: TextStyle(
                            fontSize: 14.0,
                            color: AppColor.secondaryTextColor,
                            fontWeight: FontWeight.w300),
                        children: <TextSpan>[
                          TextSpan(
                              text: widget.first
                                  ? 'Already have an account? '
                                  : 'Not member? '),
                          TextSpan(
                              text: widget.first ? 'Login' : 'Register Now!',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w900)),
                        ],
                      )),
                    ),
                  ),
                ],
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
        ]));
  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();

        UserCredential result = await _auth.signInWithCredential(credential);

        User user = result.user!;

        if (user != null) {
          print(user);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardScreen(
                        user: user,
                      )));
        } else {
          print("Error");
        }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        setState(() {
          _isLoading = false; // Complete the task
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPScreen(
                    auth: _auth,
                    verificationId: verificationId,
                    phoneNumber: phone,
                    isFirst: widget.first,
                    isAdvocate: widget.isAdvocate)));
        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (context) {
        //       return AlertDialog(
        //         title: Text("Give the code?"),
        //         content: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             TextField(
        //               controller: _codeController,
        //             ),
        //           ],
        //         ),
        //         actions: <Widget>[
        //           TextButton(
        //             child: Text("Confirm"),
        //             // textColor: Colors.white,
        //             // color: Colors.blue,
        //             onPressed: () async {
        //               final code = _codeController.text.trim();
        //               AuthCredential credential = PhoneAuthProvider.credential(
        //                   verificationId: verificationId, smsCode: code);

        //               UserCredential result =
        //                   await _auth.signInWithCredential(credential);

        //               User user = result.user!;

        //               if (user != null) {
        //                 print(user);
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => DashboardScreen(
        //                               user: user,
        //                             )));
        //               } else {
        //                 print("Error");
        //               }
        //             },
        //           )
        //         ],
        //       );
        //     });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      // codeAutoRetrievalTimeout: null
    );
    return true;
  }
}
