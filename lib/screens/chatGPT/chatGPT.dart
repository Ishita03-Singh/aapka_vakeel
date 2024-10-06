import 'dart:convert';

import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  String? prompt="";
  ChatScreen({this.prompt});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];



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

    _getAIResponse(text);
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
    String response = await getGeminiResponse(inputText);

    setState(() {
      messages.add({'role': 'bot', 'text': response});
    });
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
              itemCount: messages.length,
              itemBuilder: (context, index) {
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
          ):Container(),
        ],
      ),
    );
  }
}
