import 'package:aapka_vakeel/main.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:flutter/material.dart';

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
        Row(children: [
         Expanded(child: 
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
         ),
         SizedBox(width: 10),
         
         Expanded(child: 
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
         )
        ],)
      ),
    );
  }
}