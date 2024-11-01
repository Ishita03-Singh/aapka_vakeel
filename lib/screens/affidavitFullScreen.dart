import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:aapka_vakeel/screens/notaryScreen.dart';
import 'package:aapka_vakeel/screens/stampPaper.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:aapka_vakeel/HTTP/serverhttpHelper.dart';
import 'package:aapka_vakeel/main.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:flutter/material.dart';
// import 'dart:html' as html;

class AffidavitFullScreen extends StatefulWidget {
  String fileName;
  bool isAffidavitPage;
   AffidavitFullScreen({super.key,required this.fileName,required this.isAffidavitPage});

  @override
  State<AffidavitFullScreen> createState() => _AffidavitFullScreenState();
}

class _AffidavitFullScreenState extends State<AffidavitFullScreen> {
  bool isAIDraft=false;
  // late File draftFile;
  // Uint8List _fileContent = new Uint8List.fromList([]);
    String filePath="";
   var  draftFile;


   @override
  void initState() {
    super.initState();
    _initializeAsync();
    
   
  }
// String bytesToHex(Uint8List data) {
//   return data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(' ');
// }
Future<void> _initializeAsync() async {
  String dir= widget.isAffidavitPage?"Affidavit":"Agreements";
  String draftfile=await Serverhttphelper.fetchFileUrl(widget.fileName,dir);
  // draftFile= bytesToHex(draftfile);

    setState(() {
      filePath = draftfile??"";
    });
    if(kIsWeb)
    {
      _openPdf(filePath);
    }
    //  _filteredItems.addAll(affidavitList);
  }

Future<void> _openPdf(String url) async {
    // html.window.open(url, '_blank');  // Open in a new tab
   
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.appbar(context),
      body: Container(
        // padding: EdgeInsets.al,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText.infoText(widget.fileName),
              ),
              Container(
                color: Color(0xFFd9d9d9),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                   child:GestureDetector(
                    onTap: (){
                      isAIDraft=true;
                      setState(() {
                        
                      });
                    },
                     child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: isAIDraft?Colors.black:Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: isAIDraft?CustomText.taskBtnText("AI Based Draft"):CustomText.cancelBtnText("AI Based Draft")
                      ),
                   )),
                   Expanded(
                   child:GestureDetector(
                    onTap: (){
                      isAIDraft=false;
                      setState(() {
                        
                      });
                    },
                     child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: isAIDraft?Colors.transparent:Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: isAIDraft?CustomText.cancelBtnText("Draft by Lawyer"): CustomText.taskBtnText("Draft by Lawyer")),
                   ))
              ],),
              ),
              SingleChildScrollView(
                child: Container(
                          height: MediaQuery.of(context).size.height/1.50,

                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                        
                          // color: Colors.green,
                          child: filePath == null|| filePath==""
                                    ? Center(child: CircularProgressIndicator())
                                    : PDFView(
                                      // nightMode: true,
                                        filePath: filePath!,
                                        // nightMode: true,
                                        onError: (error) {
                                          print(error);
                                        },
                                        onViewCreated: (controller) {
                                          print(controller.getCurrentPage());
                                        },
                                        onRender: (pages) {
                                          print(pages);
                                        },
                                      ),
                        ),
                      ),
                      customButton.smalltaskButton("Stamp Paper", (){
    // Navigator.push(
                        // context,
                        // PageTransition(
                        //     child: NotaryScreen(filePath: filePath,),
                        //     type: PageTransitionType.rightToLeft));
              })
                    ],
                  ),
                ),
              )
              

        ],),
      ),
    );
  }
  // Future<String> saveUint8ListToFile(Uint8List data, String filename) async {
//   final directory = await getApplicationCacheDirectory();
//   final file = File('${directory.path}/$filename');
//   await file.writeAsBytes(data);
//   print('File saved successfully at ${file.path}');
//   return await file.readAsString();
// }
}