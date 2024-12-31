import 'dart:convert';
import 'dart:io';

import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/screens/affidavitScreen.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/cutom_message.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'dart:html' as html;


class ChatScreen extends StatefulWidget {
  String? prompt="";
  String? filename="";
  ChatScreen({this.prompt,this.filename});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
 final ScrollController _scrollController =ScrollController();


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.prompt!=null&& widget.prompt!=""){
      _sendMessage(widget.prompt!);
    }
  }
  void _sendMessage(String text) {
    setState(() {
      messages.add({'role': 'user', 'text': text});
    });
    scrollToBottom();
   
    _getAIResponse(text);
     // Scroll to the bottom of the list
  
  }
Future<String> getGeminiResponse(String inputText) async {
  const String api = 'AIzaSyC2euOa3jvPZh5pWFVQJC5-xz2aL_zoGG0'; // Replace with your actual API
  const String endpointUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=${api}'; // Replace with your actual endpoint

  final response = await http.post(
    Uri.parse(endpointUrl),
    // headers: {
    //   // 'Authorization': 'Bearer $apiKey',
    //   'Content-Type': 'application/json',
    // },
    body: jsonEncode({
      // 'instances': [
      //   {'content': inputText}
      // ]
      "contents":[{"parts":[{"text":"${inputText}"}]}]
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    return responseData["candidates"][0]["content"]["parts"][0]["text"] ?? 'Error: Invalid response';
  } else {
    return 'Error: Failed to get a response from Gemini';
  }
}
  Future<void> _getAIResponse(String inputText) async {
    // Call the API (will implement in Step 4)
    if(widget.prompt!=null)
    context.loaderOverlay.show();
    String response = await getGeminiResponse(inputText);
    if(widget.prompt!=null)
    context.loaderOverlay.hide();

    setState(() {
      messages.add({'role': 'bot', 'text': response});
    });
    scrollToBottom();
    
  }

  scrollToBottom(){
      WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
   Future<void> _generateWordFile() async {
    // final text = messages[1]['text']!;

    // // prepare
    // final bytes = utf8.encode(text);
    // final blob = html.Blob([bytes]);
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // final anchor = html.document.createElement('a') as html.AnchorElement
    //   ..href = url
    //   ..style.display = 'none'
    //   ..download = 'AIaffidavit.txt';
    // html.document.body!.children.add(anchor);

    // // download
    // anchor.click();

    // // cleanup
    // html.document.body!.children.remove(anchor);
    // html.Url.revokeObjectUrl(url);
  }

   Future<String> saveTextFileToDownloads() async {
    try{
     final text = messages[1]['text']!;
    final fileName = 'AIaffidavit.pdf';

  // Request storage permission for Android 10 or lower
  // if (await Permission.storage.request().isGranted) {
    // Get the Downloads directory
    final directory = Directory('/storage/emulated/0/Download');
    if (directory.existsSync()) {
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);

      // Write the text content to the file
      await file.writeAsString(text, encoding: utf8);
      var fileList= await MySharedPreferences.instance.getUserDownloadedFiles();
      fileList.add(file.path);
      MySharedPreferences.instance.setUserDownloadedFiles(fileList);

      // Notify the user of the file location
      print("File saved at $filePath");
      return "File saved at $filePath";
    } else {
      
      print("Could not access the Downloads directory.");
       return "Could not access the Downloads directory";
    }
    }
    catch(ex){
       return "Could not access the Downloads directory";
    }
  // } else {
  //   print("Storage permission is denied.");
  // }
}








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar.appbar("Aapka Vakeel Bot"),
      body: Column(
        children: [
         
          MyAppBar.appbar(context,head:"Aapka Vakeel Bot"),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                if( index==0&&widget.prompt!=null && widget.prompt!=""){
                  return Container();

                }else{
                
                final message = messages[index];
                return ListTile(
                  title: Align(
                    alignment: message['role'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: message['role'] == 'user' ? Radius.circular(16) : Radius.circular(0),
                        bottomRight: message['role'] == 'user' ? Radius.circular(0) : Radius.circular(16),
                      ),
                        color: message['role'] == 'user'
                          ? Colors.black
                          : Colors.white,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(message['text']!,style: TextStyle(color: message['role'] == 'user'
                          ? Colors.white
                          : Colors.black,),),
                    ),
                  ),
                );
                  }
                
              },
            ),
          ),
         widget.prompt==null||widget.prompt==""?
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                        decoration: MyTextField.outlinedTextField("Enter your query here."),
                        keyboardType: TextInputType.text,
                        controller: _controller,
                        // readOnly: true,
                        //  validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your name';
                        //     }
                        //     return null;
                        //   },
                        enabled: true,
                        enableInteractiveSelection: false,
                        cursorColor: AppColor.primaryTextColor,
                        style: TextStyle(
                                    color: AppColor.primaryTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                  ),
                  IconButton(
                    icon: Icon(Icons.send_rounded,size: 30,color: Colors.black,),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _sendMessage(_controller.text);
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ): messages.length>1?
            Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: customButton.taskButton("Export as PDF", ()async {
          context.loaderOverlay.show();
           var res= await  saveTextFileToDownloads();
          context.loaderOverlay.hide();
          CustomMessenger.defaultMessenger(context, res,);

          }))])))
          :Container(),
        ],
      ),
    );
  }
}
