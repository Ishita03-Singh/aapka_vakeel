import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
class Serverhttphelper{
  
  static String ip="192.168.1.34";
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

   static Future<String> getAffidavitFile(String filename,String dirname) async {
    var _fileContent;
     Uri uri = Uri.parse('http://$ip:8080/file')
    .replace(queryParameters: {
      'fileName': filename,
      'dirName': dirname
    });
    // List<String> _filenames = [];
     final response = await http.get(uri);

    if (response.statusCode == 200) {
      final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/downloaded.pdf');
        await file.writeAsBytes(response.bodyBytes);


        // var data= await file.readAsBytes();
        // print(data);
    //  if(response.body!="[]"||response.body!=""){
    //    List<int> byteList = response.body
    // .replaceAll('[', '')
    // .replaceAll(']', '')
    // .split(',')
    // .map((s) => int.parse(s.trim()))
    // .toList(); 
    //  Uint8List byteArray = Uint8List.fromList(byteList);
     return file.path;
    //  }
      
    } else {    
      print("Failed to load filenames: ${response.reasonPhrase}");
      // _fileContent = [];
      return "Failed to load filenames: ${response.reasonPhrase}";
      
    }
    
    // return _fileContent;

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