import 'package:aapka_vakeel/main.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:flutter/material.dart';

import '../utilities/colors.dart';
import '../utilities/validation.dart';

class LegalCases extends StatefulWidget {
  const LegalCases({super.key});

  @override
  State<LegalCases> createState() => _LegalCasesState();
}

class _LegalCasesState extends State<LegalCases>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
   final List<String> list=["Divorce & Separation","Domestic Violence","Bail","Cheating partner","Cheque bounce & Money recovery","Rape case","Banking fraud case","Cyber Crime","Sexual Harrasement at work place","Employment and salary issue","Legal notice ","Criminal complaint","Due Diligence","Property dispute","Superdari/Release of Vehicle","HARERA","Trademark/Copyright/Patent","Cryptocurrency issue/ Bank account freeze"];
  String dropdownValue="";
     final List<String> Languagelist=["English","Hindi","Telugu","Kannada","Assamese","Marathi","Tamil","Bengali","Tamil","Malayalam","Gujrati"];
  String languagedropdownValue="";
  TextEditingController nameController =TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController phonenumberController =TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.appbar(context),
      body: Container(
        padding: EdgeInsets.all(12),
        child: 
        Column(
          children: [
            Row(
              children: [
             Expanded(child: 
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.RegularDarkText("Problem type"),
                      DropdownMenu<String>(
                              width: MediaQuery.of(context).size.width,
                                initialSelection: list.first,
                                onSelected: (String? value) {
                                  // This is called when the user selects an item.
                                  
                                  setState(() {
                                    dropdownValue = value!;
                                
                                  });
                                },
                                dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                                  return DropdownMenuEntry<String>(value: value, label: value);
                                }).toList(),
                              ),
                    ],
                  ),
             ),
             SizedBox(width: 10),
             
             Expanded(child: 
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.RegularDarkText("Language"),
                      DropdownMenu<String>(
                              width: MediaQuery.of(context).size.width,
                                initialSelection: Languagelist.first,
                                onSelected: (String? value) {
                                  // This is called when the user selects an item.
                                  
                                  setState(() {
                                    languagedropdownValue = value!;
                                
                                  });
                                },
                                dropdownMenuEntries: Languagelist.map<DropdownMenuEntry<String>>((String value) {
                                  return DropdownMenuEntry<String>(value: value, label: value);
                                }).toList(),
                              ),
                    ],
                  ),
             )
            ],),

              SizedBox(height: 50),
              giveInputField("Name (as on Aadhar card)", nameController, true,TextInputType.name),
              giveInputField("Phone number", phonenumberController, true,TextInputType.phone),
              giveInputField("Address", addressController, true,TextInputType.streetAddress),
          ],
        )

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
                validationService.validate(value!, textInputType);
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter ${HeadText}';
                  // }
                  // return null;
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