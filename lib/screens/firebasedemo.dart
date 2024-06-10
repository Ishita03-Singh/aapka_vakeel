import 'package:aapka_vakeel/screens/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class PhoneOTPVerification extends StatefulWidget {
//   const PhoneOTPVerification({Key? key}) : super(key: key);

//   @override
//   State<PhoneOTPVerification> createState() => _PhoneOTPVerificationState();
// }

// class _PhoneOTPVerificationState extends State<PhoneOTPVerification> {
//   TextEditingController phoneNumber = TextEditingController();
//   TextEditingController otp = TextEditingController();
//   bool visible = false;
//   var temp;
//   late FirebaseAuth auth;

//   @override
//   void dispose() {
//     phoneNumber.dispose();
//     otp.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     auth = FirebaseAuth.instance;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Firebase Phone OTP Authentication"),
//       ),
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             inputTextField("Contact Number", phoneNumber, context),
//             visible ? inputTextField("OTP", otp, context) : SizedBox(),
//             !visible ? SendOTPButton("Send OTP") : SubmitOTPButton("Submit"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget SendOTPButton(String text) => ElevatedButton(
//         onPressed: () async {
//           setState(() {
//             visible = !visible;
//           });
//           temp = await firebaseAuthentication.sendOTP(phoneNumber.text, auth);
//         },
//         child: Text(text),
//       );

//   Widget SubmitOTPButton(String text) => ElevatedButton(
//         onPressed: () => firebaseAuthentication.authenticate(temp, otp.text),
//         child: Text(text),
//       );

//   Widget inputTextField(String labelText,
//           TextEditingController textEditingController, BuildContext context) =>
//       Padding(
//         padding: EdgeInsets.all(10.00),
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width / 1.5,
//           child: TextFormField(
//             obscureText: labelText == "OTP" ? true : false,
//             controller: textEditingController,
//             decoration: InputDecoration(
//               hintText: labelText,
//               hintStyle: TextStyle(color: Colors.blue),
//               filled: true,
//               fillColor: Colors.blue[100],
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.transparent),
//                 borderRadius: BorderRadius.circular(5.5),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.transparent),
//                 borderRadius: BorderRadius.circular(5.5),
//               ),
//             ),
//           ),
//         ),
//       );
// }

// class FirebaseAuthentication {
//   String phoneNumber = "";

//   sendOTP(String phoneNumber, FirebaseAuth auth) async {
//     this.phoneNumber = phoneNumber;
//     // FirebaseAuth auth = FirebaseAuth.instance;
//     // ConfirmationResult result = await auth.verifyPhoneNumber(
//     //   '+91$phoneNumber',
//     // );

//     var result = await auth.verifyPhoneNumber(
//       phoneNumber: '+91$phoneNumber',
//       timeout: Duration(seconds: 60),
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // Automatically sign in the user when verification is completed
//         try {
//           UserCredential userCredential =
//               await auth.signInWithCredential(credential);
//           print('User signed in: ${userCredential.user}');
//         } catch (e) {
//           print('Failed to sign in: $e');
//         }
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         // Handle the error
//         print('Verification failed: ${e.message}');
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         // Save the verificationId for later use to verify the code
//         print(
//             'Verification code sent to the phone. Verification ID: $verificationId');
//         // Store verificationId and resendToken if you need them
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Handle the timeout scenario
//         print('Auto-retrieval timeout. Verification ID: $verificationId');
//       },
//     );
//     printMessage("OTP Sent to +91 $phoneNumber");
//     return result;
//   }

//   authenticate(ConfirmationResult confirmationResult, String otp) async {
//     UserCredential userCredential = await confirmationResult.confirm(otp);
//     userCredential.additionalUserInfo!.isNewUser
//         ? printMessage("Authentication Successful")
//         : printMessage("User already exists");
//   }

//   printMessage(String msg) {
//     debugPrint(msg);
//   }
// }

// FirebaseAuthentication firebaseAuthentication = new FirebaseAuthentication();

class LoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

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
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Give the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Confirm"),
                    // textColor: Colors.white,
                    // color: Colors.blue,
                    onPressed: () async {
                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: code);

                      UserCredential result =
                          await _auth.signInWithCredential(credential);

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
                    },
                  )
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      // codeAutoRetrievalTimeout: null
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey)),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Mobile Number"),
                controller: _phoneController,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: TextButton(
                  child: Text("LOGIN"),
                  // textColor: Colors.white,
                  // padding: EdgeInsets.all(16),
                  onPressed: () {
                    final phone = _phoneController.text.trim();

                    loginUser(phone, context);
                  },
                  // color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
