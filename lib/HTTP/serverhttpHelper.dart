import 'dart:convert';

import 'package:http/http.dart' as http;
class Serverhttphelper{
  
  static String ip="192.168.1.46";
  static Future<List<String>> getAffidavitFileList() async {
    var _fileContent=[];
    List<String> _filenames = [];
     final response = await http.get(Uri.parse('http://${ip}:8080/getAffidavitFiles'));

    if (response.statusCode == 200) {
      _filenames = List<String>.from(json.decode(response.body));   
    } else {    
      print("Failed to load filenames: ${response.reasonPhrase}");
      _filenames = [];
      
    }
    return _filenames;

  }

  static Future<List<String>> getAgreementFileList() async {
    var _fileContent=[];
    List<String> _filenames = [];
     final response = await http.get(Uri.parse('http://${ip}:8080/getAgreementFiles'));

    if (response.statusCode == 200) {
      _filenames = List<String>.from(json.decode(response.body));   
    } else {    
      print("Failed to load filenames: ${response.reasonPhrase}");
      _filenames = [];
      
    }
    return _filenames;

  }
}