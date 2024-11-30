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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OTPScreen extends StatefulWidget {
  // User user;
  var verificationId;
  FirebaseAuth auth;
  String phoneNumber;
  bool isFirst;
  bool isAdvocate;
  OTPScreen(
      {super.key,
      required this.verificationId,
      required this.auth,
      required this.phoneNumber,
      required this.isAdvocate,
      required this.isFirst});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool _isLoading = false;
  TextEditingController otpController = new TextEditingController();
  List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // late UserCredential userCredential;

  @override
  void dispose() {
     _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: MyAppBar.appbar(context),
      body: Stack(
        children: [
         SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText.headText("OTP Verification"),
                // Padding(padding: EdgeInsets.all(12)),
                CustomText.infoText("Enter the 6 digit code sent to "),
                CustomText.infoText(widget.phoneNumber),
                Padding(padding: EdgeInsets.only(top: 12)),
                FocusScope(
                  node: _focusScopeNode,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(6, (index) {
                              return Container(
                                width: MediaQuery.of(context).size.width/8,
                                height: 60,
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
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                   inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                     LengthLimitingTextInputFormatter(1),
                                ],
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
                                      // FocusScope.of(context).nextFocus();
                                       FocusScope.of(context)
                                          .requestFocus(_focusNodes[index + 1]);
                                    } else if (value.isEmpty && index > 0) {
                                      _focusNodes[index].unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_focusNodes[index - 1]);
                                          // KeyboardLockMode.numLock;
                                      // FocusScope.of(context).previousFocus();

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
                ),
                Padding(padding: EdgeInsets.only(top: 12)),
                customButton.taskButton("Verify now", () async {
                  String code = "";
                  for (var controller in _controllers) {
                    code += controller.text.trim();
                  }
                  setState(() {
                    _isLoading=true;
                  });
          
                  AuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId, smsCode: code);
          
                  UserCredential result =
                      await widget.auth.signInWithCredential(credential);
          
                  User user = result.user!;
          
                  if (user != null) {
                    setState(() {
                      _isLoading=false;
                    });
                    print(user);
                    if (widget.isFirst) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserRegistrationForm(
                                  isAdvocate: widget.isAdvocate,
                                  userCredential: result,)));
                    } else {
                      
                      //get user from firebase

                      // MySharedPreferences.instance.setISLoggedIn();

                       print(user.uid);
                       try{
                        var userRes=false;
                        DocumentSnapshot userSnapshot= await _firestore.collection('users').doc(user.uid).get();
                             if (userSnapshot.exists) {
                              userRes=true;
                             }
                             else{
                              userSnapshot= await _firestore.collection('advocates').doc(user.uid).get();
                               if (userSnapshot.exists) {
                                  userRes=true;
                                }
                                else{
                                  userRes=false;
                                }
                             }
                        // Check if the document exists
                        if (userRes) {
                          // Access the data
                          Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
                          print('User data: $userData');
                             userClass.uid=user.uid;
                              userClass.email=userData?["email"];
                              userClass.isAdvocate=false;
                              userClass.displayName=userData?["firstName"]+" "+userData?["lastName"];
                              userClass.address=userData?["address"];
                              userClass.barRegistrationNo= userData?["barRegistrationNo"]??"";
                              userClass.barRegistrationCertificate=userData?["barRegistrationCertificate"] ??"";
                              userClass.phoneNumber= userData?["phoneNumber"];
                              userClass.introduction=userData?["introduction"]??"";
                              userClass.experience=userData?["experience"]??"";
                              userClass.charges=userData?["charges"]??"";
                              userClass.skills=userData?["skills"]??"";
                                 
                                 if(userClass.isAdvocate){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdvocateDashboard(
                                                  user: user,
                                                  userclass: userClass,
                                                )));

                                 }
                                 else{
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Dashboard(
                                                  user: user,
                                                  userclass: userClass,
                                                )));
                                 }
                     
                     
                        } else {
                          print('No such document exists!');
                          CustomMessenger.defaultMessenger(context, "No such user found");
                        }

                            //  userClass.uid=user.uid;
                            //   userClass.email=Muser["email"];
                            //   userClass.displayName=Muser["firstName"]+Muser["lastName"];
                            //   userClass.address=Muser["address"];
                            //   userClass.barRegistrationNo= Muser["barRegistrationNo"]??"";
                            //   userClass.barRegistrationCertificate=Muser["barRegistrationCertificate"] ??"";
                            //   userClass.phoneNumber= Muser["phoneNumber"];
                            //   userClass.introduction=Muser["introduction"]??"";
                            //   userClass.experience=Muser["experience"]??"";
                            //   userClass.charges=Muser["charges"]??"";
                            //   userClass.skills=Muser["skills"]??"";
                         
                       }
                       catch(ex){
                        CustomMessenger.defaultMessenger(context, "Error getting user");
                        print(ex);
                       }
                       
                        // }
                      // });

                      
                    }
                  } else {
                    print("Error");
                  }
                }),
                Padding(padding: EdgeInsets.all(8)),
                Center(
                  child: GestureDetector(
                    onTap: ()async{
                      setState(() {
                        _isLoading=true;
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
                            style: const TextStyle(fontWeight: FontWeight.w900)),
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
        ]
      ),
    );
  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    // FirebaseAuth _auth = FirebaseAuth.instance;

    widget.auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();

        UserCredential result = await widget.auth.signInWithCredential(credential);

        User user = result.user!;

        if (user != null) {
          
        } else {
          print("Error");
        }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (FirebaseAuthException exception) {
         CustomMessenger.defaultMessenger(context,exception.message.toString());
        setState(() {
          _isLoading=false;
        });
        print(exception);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        setState(() {
          _isLoading = false; // Complete the task
        });
        
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        widget.verificationId=verificationId;
      },
      // codeAutoRetrievalTimeout: null
    );
    return true;
  }
}
class SingleDigitInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 1) {
      return oldValue;
    }
    return newValue;
  }
}