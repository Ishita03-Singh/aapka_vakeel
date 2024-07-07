import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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

   static Future<Uint8List> getAffidavitFile(String filename) async {
    var _fileContent;
     Uri uri = Uri.parse('http://$ip:8080/file')
    .replace(queryParameters: {
      'fileName': filename,
      'dirName': 'AgreementDocument'
    });
    // List<String> _filenames = [];
     final response = await http.get(uri);

    if (response.statusCode == 200) {
     if(response.body!="[]"||response.body!=""){
       List<int> byteList = response.body
    .replaceAll('[', '')
    .replaceAll(']', '')
    .split(',')
    .map((s) => int.parse(s.trim()))
    .toList(); 
     Uint8List byteArray = Uint8List.fromList(byteList);
     return byteArray;
     }
      
    } else {    
      print("Failed to load filenames: ${response.reasonPhrase}");
      _fileContent = [];
      
    }
    return _fileContent;

  }


     static Future<List<String>> getAgreementFile(String filename) async {
    var _fileContent;
    // List<String> _filenames = [];
    Uri uri = Uri.parse('http://$ip:8080/file')
    .replace(queryParameters: {
      'fileName': filename,
      'dirName': 'AgreementDocument'
    });
     final response = await http.get(uri);

    if (response.statusCode == 200) {
      _fileContent = response.body;   
    } else {    
      print("Failed to load filenames: ${response.reasonPhrase}");
      _fileContent = new File("");
      
    }
    return _fileContent;

  }
}