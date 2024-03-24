import 'package:aapka_vakeel/main.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:page_transition/page_transition.dart';
import '../Utilities/strings.dart';
import 'package:country_picker/country_picker.dart';

class PhoneNumPage extends StatefulWidget {
  var first;
  PhoneNumPage({super.key, this.first});

  @override
  State<PhoneNumPage> createState() => _PhoneNumPageState();
}

class _PhoneNumPageState extends State<PhoneNumPage> {
  Country country = Country.worldWide;
  TextEditingController phonenumController =
      TextEditingController(text: "+91 ");
  TextEditingController countryController = TextEditingController();
  bool termsCond = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: MyAppBar.appbar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText.headText(
                widget.first != null ? "Let get started" : "Welcome Back!"),
            Padding(padding: EdgeInsets.all(12)),
            CustomText.infoText("Enter your mobile number"),
            Padding(padding: EdgeInsets.all(4)),
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
                      decoration: MyTextField.filledTextField("", ""),
                      dropdownIcon: Icon(Icons.keyboard_arrow_down_rounded),
                      style: TextStyle(
                          color: AppColor.primaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      initialCountryCode: 'IN',
                      onCountryChanged: (value) {
                        phonenumController.text = "+" + value.dialCode + " ";
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 110,
                    child: TextField(
                        decoration: MyTextField.filledTextField("+91", ""),
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
                ],
              ),
            ),
            Theme(
                data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.black, useMaterial3: true),
                child: ListTileTheme(
                  horizontalTitleGap: 0,
                  child: CheckboxListTile(
                    contentPadding: const EdgeInsets.all(0),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: CustomText.infoText(
                      "I agree to the terms and conditions",
                    ),
                    activeColor: AppColor.tertiaryColor,
                    // fillColor: MaterialStatePropertyAll(Color(0xffececec)),
                    checkColor: AppColor.tertiaryTextColor,
                    value: termsCond,
                    onChanged: (newValue) =>
                        setState(() => termsCond = newValue!),
                  ),
                )),
            Padding(padding: EdgeInsets.all(4)),
            customButton.taskButton("Continue", () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: PhoneNumPage(),
                      type: PageTransitionType.rightToLeft));
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
                  TextSpan(text: 'Already have an account? '),
                  TextSpan(
                      text: 'Login',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
