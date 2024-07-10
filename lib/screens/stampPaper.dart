import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:flutter/material.dart';

class StampPaper extends StatefulWidget {
  const StampPaper({super.key});

  @override
  State<StampPaper> createState() => _StampPaperState();
}

class _StampPaperState extends State<StampPaper> {
TextEditingController stateController= new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
      child: Column(children: [
        CustomText.headText("E-Stamp Paper"),
        Form(
       key: _formKey,
      child: Column(children: [
      TextFormField(
                decoration: MyTextField.outlinedTextField(""),
                keyboardType: TextInputType.text,
                controller: stateController,
                // readOnly: true,
                 validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter state';
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
        ],))
      ],),
      ),
    );
  }
}