import 'package:aapka_vakeel/screens/DashboardScreen.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OTPScreen extends StatefulWidget {
  // User user;
  var verificationId;
  FirebaseAuth auth;
  String phoneNumber;
  OTPScreen(
      {super.key,
      required this.verificationId,
      required this.auth,
      required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = new TextEditingController();
  List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: MyAppBar.appbar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText.headText("OTP Verification"),
            // Padding(padding: EdgeInsets.all(12)),
            CustomText.infoText("Enter the 6 digit code sent to "),
            CustomText.infoText(widget.phoneNumber),
            Padding(padding: EdgeInsets.only(top: 12)),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 45,
                          height: 45,
                          margin: index > 0
                              ? EdgeInsets.symmetric(horizontal: 5)
                              : EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(
                            color: Color(0xffececec),
                            border: Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: TextStyle(
                                fontSize: 24,
                                color: AppColor.secondaryTextColor),
                            decoration: InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                _focusNodes[index].unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_focusNodes[index + 1]);
                              } else if (value.isEmpty && index > 0) {
                                _focusNodes[index].unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_focusNodes[index - 1]);
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    // Container(
                    //   width: 100,
                    //   child: TextField(
                    //       decoration:
                    //           MyTextField.filledTextFieldCountryCode(""),
                    //       keyboardType: TextInputType.phone,
                    //       controller: otpController,
                    //       readOnly: true,
                    //       // enabled: true,
                    //       // enableInteractiveSelection: false,
                    //       // cursorColor: AppColor.primaryTextColor,
                    //       style: TextStyle(
                    //           color: AppColor.primaryTextColor,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w900)),
                    // ),
                  ]),
            ),
            Padding(padding: EdgeInsets.only(top: 12)),
            customButton.taskButton("Verify now", () async {
              String code = "";
              for (var controller in _controllers) {
                code += controller.text.trim();
              }

              AuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId, smsCode: code);

              UserCredential result =
                  await widget.auth.signInWithCredential(credential);

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
            }),
            Padding(padding: EdgeInsets.all(8)),
            Center(
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
                      style: const TextStyle(fontWeight: FontWeight.w900)),
                ],
              )),
            ),
          ],
        ),
      ),
    );

    Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: otpController,
        ),
        TextButton(
          child: Text("Confirm"),
          // textColor: Colors.white,
          // color: Colors.blue,
          onPressed: () async {
            final code = otpController.text.trim();
            AuthCredential credential = PhoneAuthProvider.credential(
                verificationId: widget.verificationId, smsCode: code);

            UserCredential result =
                await widget.auth.signInWithCredential(credential);

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
    ));
  }
}
