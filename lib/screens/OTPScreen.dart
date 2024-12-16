import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/screens/AdvocateRegisterScreen.dart';
import 'package:aapka_vakeel/screens/Dashboard.dart';
import 'package:aapka_vakeel/screens/DashboardScreen.dart';
import 'package:aapka_vakeel/screens/advocate/AdvocateDashboard.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/cutom_message.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:sms_receiver/sms_receiver.dart';
import 'package:video_call/constants/colors.dart';

class OTPScreen extends StatefulWidget {
  // User user;
  var verificationId;
  FirebaseAuth auth;
  String phoneNumber;
  bool isFirst;
  bool isAdvocate;
  final TextEditingController otpContoller;
  OTPScreen(
      {super.key,
      required this.verificationId,
      required this.auth,
      required this.phoneNumber,
      required this.isAdvocate,
      required this.isFirst,
      required this.otpContoller});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool _isLoading = false;
  // TextEditingController otpController = new TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // String? _textContent = 'Waiting for messages...';
  // SmsReceiver? _smsReceiver;
  // late UserCredential userCredential;

  void updateOTP(String otp) {
    setState(() {
      widget.otpContoller.text = otp; // Update the controller
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: MyAppBar.appbar(context),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomText.headText("OTP Verification"),
                    // Padding(padding: EdgeInsets.all(12)),
                    CustomText.infoText("Enter the 6 digit code sent to "),
                    CustomText.infoText(widget.phoneNumber),
                    Padding(padding: EdgeInsets.only(top: 12)),
                    Pinput(
                      controller: widget.otpContoller,
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 50,
                        height: 60,
                        textStyle: TextStyle(
                          fontSize: 24,
                          color: AppColor.secondaryTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffececec),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                      ),
                      onChanged: (value) {
                        // Check if the input value is numeric and has exactly 6 digits

                        if (value.length == 6 && int.tryParse(value) != null) {
                          // Valid input

                          print('Valid OTP: $value');
                        } else {
                          // Invalid input, can display an error message or handle it as needed

                          print('Invalid OTP, must be 6 digits long');
                        }
                      },
                      
                      // onCompleted: (pin) async {
                      //   print("Entered OTP: $pin");
                      //   String code = otpController
                      //       .text; // Automatically verify OTP after autofill

                      //   await verifyPhoneNumber(
                      //     verificationId: widget.verificationId,
                      //     otpCode: code,
                      //     context: context,
                      //     auth: widget.auth,
                      //     firestore: _firestore,
                      //     isFirst: widget.isFirst,
                      //     isAdvocate: widget.isAdvocate,
                      //     setLoading: (bool value) {
                      //       setState(() {
                      //         _isLoading = value;
                      //       });
                      //     },
                      //     userClass: userClass,
                      //   );
                      // },
                    ),
                    Padding(padding: EdgeInsets.only(top: 12)),
                    customButton.taskButton("Verify now", () async {
                      String code = widget.otpContoller.text;

                      await verifyPhoneNumber(
                        verificationId: widget.verificationId,
                        otpCode: code,
                        context: context,
                        auth: widget.auth,
                        firestore: _firestore,
                        isFirst: widget.isFirst,
                        isAdvocate: widget.isAdvocate,
                        setLoading: (bool value) {
                          setState(() {
                            _isLoading = value;
                          });
                        },
                        userClass: userClass,
                      );
                    }),
                    Padding(padding: EdgeInsets.all(8)),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await loginUser(widget.phoneNumber, context);
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
                            TextSpan(text: 'Didn’t recieve code? '),
                            TextSpan(
                                text: 'Resend Code',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900)),
                          ],
                        )),
                      ),
                    )
                  ],
                ),
              
                Expanded(
                child: Image.asset(
                    StrLiteral.login1,
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
      ]),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _smsReceiver = SmsReceiver(onSmsReceived, onTimeout: onTimeout);
  //   // _startListening();
  //   requestPermissions();
  // }

  // void onSmsReceived(String? message) {
  //   setState(() {
  //     _textContent = message;
  //   });
  // }

  // void onTimeout() {
  //   setState(() {
  //     _textContent = 'Timeout!!!';
  //   });
  // }

  // void requestPermissions() async {
  //   var status = await Permission.sms.request();
  //   if (status.isGranted) {
  //     _startListening();
  //   } else {
  //     // Handle permission denial
  //   }
  // }

  // void _startListening() async {
  //   if (_smsReceiver == null) return;
  //   // await _smsReceiver?.startListening();
  //   setState(() {
  //     _textContent = 'Waiting for messages...';
  //   });
  // }

  // void _stopListening() async {
  //   try {
  //     if (_smsReceiver == null) return;
  //     await _smsReceiver?.stopListening();
  //     setState(() {
  //       _textContent = 'Listener Stopped';
  //     });
  //   } catch (ex) {
  //     print(ex);
  //   }
  // }

  Future<void> verifyPhoneNumber({
    required String verificationId,
    required String otpCode,
    required BuildContext context,
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required bool isFirst,
    required bool isAdvocate,
    required Function(bool) setLoading,
    required UserClass userClass,
  }) async {
    try {
      setLoading(true);

      // Create credential
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpCode);

      // Sign in with credential
      UserCredential result = await auth.signInWithCredential(credential);
      User user = result.user!;

      if (user != null) {
        setLoading(false);

        if (isFirst) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserRegistrationForm(
                isAdvocate: isAdvocate,
                userCredential: result,
              ),
            ),
          );
          return;
        }

        // Check existing user
        var userRes = false;
        DocumentSnapshot userSnapshot =
            await firestore.collection('users').doc(user.uid).get();

        if (userSnapshot.exists) {
          userRes = true;
        } else {
          userSnapshot =
              await firestore.collection('advocates').doc(user.uid).get();
          userRes = userSnapshot.exists;
        }

        if (!userRes) {
          CustomMessenger.defaultMessenger(context, "No such user found");
          return;
        }

        // Parse user data
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        // Update user class
        userClass.uid = user.uid;
        userClass.email = userData?["email"];
        userClass.isAdvocate = false;
        userClass.displayName =
            "${userData?["firstName"]} ${userData?["lastName"]}";
        userClass.address = userData?["address"];
        userClass.barRegistrationNo = userData?["barRegistrationNo"] ?? "";
        userClass.barRegistrationCertificate =
            userData?["barRegistrationCertificate"] ?? "";
        userClass.phoneNumber = userData?["phoneNumber"];
        userClass.introduction = userData?["introduction"] ?? "";
        userClass.experience = userData?["experience"] ?? "";
        userClass.charges = userData?["charges"] ?? "";
        userClass.skills = userData?["skills"] ?? "";

        // Navigate based on user type
        if (userClass.isAdvocate) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdvocateDashboard(
                user: user,
                userclass: userClass,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(
                user: user,
                userclass: userClass,
              ),
            ),
          );
        }
      }
    } catch (ex) {
      setLoading(false);
      CustomMessenger.defaultMessenger(context, "Error getting user");
      print(ex);
    }
  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    // FirebaseAuth _auth = FirebaseAuth.instance;

    widget.auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();

        UserCredential result =
            await widget.auth.signInWithCredential(credential);

        User user = result.user!;

        if (user != null) {
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
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        widget.verificationId = verificationId;
      },
      // codeAutoRetrievalTimeout: null
    );
    return true;
  }
}

class SingleDigitInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 1) {
      return oldValue;
    }
    return newValue;
  }
}
