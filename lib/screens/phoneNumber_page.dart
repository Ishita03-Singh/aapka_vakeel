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
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: MyAppBar.appbar(context),
        body: Stack(children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomText.headText(widget.first
                            ? "Lets get started"
                            : "Welcome Back!"),
                        // Padding(padding: EdgeInsets.all(12)),
                        CustomText.infoText(
                            "Embrace the future of law with Aapka Vakeel. Our innovative application combines technology with legal expertise to deliver unparalleled service."),
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
                                  pickerDialogStyle:
                                      PickerDialogStyle(width: 300),
                                  flagsButtonPadding: const EdgeInsets.only(
                                      left: 8, right: 1, top: 8, bottom: 8),
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
                                    IntrinsicWidth(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 8),
                                        child: TextField(
                                          decoration: MyTextField
                                              .filledTextFieldCountryCode(""),
                                          keyboardType: TextInputType.phone,
                                          controller: countryCodeController,
                                          readOnly: true,
                                          style: TextStyle(
                                            color: AppColor.primaryTextColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        decoration: MyTextField.PhoneText(
                                            "Enter Phone Number"),
                                        keyboardType: TextInputType.phone,
                                        controller: phonenumController,
                                        enabled: true,
                                        enableInteractiveSelection: false,
                                        cursorColor: AppColor.primaryTextColor,
                                        style: TextStyle(
                                          color: AppColor.primaryTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // if (widget.first)
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Color(0xFF0D1B2A),
                            useMaterial3: true,
                          ),
                          child: ListTileTheme(
                            horizontalTitleGap: 0,
                            child: CheckboxListTile(
                              contentPadding: const EdgeInsets.all(0),
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CustomText.infoText("I agree to the "),
                                    GestureDetector(
                                      onTap: () {
                                        MyAppBar.launchURL(
                                            'http://aapkavakeel.com/#/terms');
                                      },
                                      child: Container(
                                        child: Text(
                                          "terms and conditions",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.underline,
                                            color: AppColor.primaryTextColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow
                                              .ellipsis, // Handle overflow
                                          maxLines: 1, // Limit lines if needed
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              activeColor: AppColor.tertiaryColor,
                              checkColor: AppColor.tertiaryTextColor,
                              value: termsCond,
                              onChanged: (newValue) =>
                                  setState(() => termsCond = newValue!),
                            ),
                          ),
                        ),

                        Padding(padding: EdgeInsets.only(top: 12)),
                        customButton.taskButton("Continue", () {
                          if (phonenumController.text.isEmpty ||
                              phonenumController.text.length != 10) {
                            CustomMessenger.defaultMessenger(
                                context, "Please enter valid phone number");
                            return;
                          }
                          if (!termsCond) {
                            CustomMessenger.defaultMessenger(context,
                                "Please accept our terms and conditions");
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
                                    text: widget.first
                                        ? 'Login'
                                        : 'Register Now!',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900)),
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    StrLiteral.login1,
                    height: MediaQuery.of(context).size.height / 2,
                  )
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
        CustomMessenger.defaultMessenger(context, exception.message.toString());
        setState(() {
          _isLoading = false;
        });
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
