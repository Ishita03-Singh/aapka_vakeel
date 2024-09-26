import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
class Serverhttphelper{
  
  static String ip="192.168.1.34";
  static Future<List<String>> getAffidavitFileList() async {
    // String ip=  await MySharedPreferences.instance.getIP();
    var _fileContent=[];
    List<String> _filenames = [];
     final response =  await http.get(Uri.parse('http://${ip}:8080/getAffidavitFiles'));

    if (response.statusCode == 200) {
      _filenames = List<String>.from(json.decode(response.body));   
    } else {    
      print("Failed to load filenames: ${response.reasonPhrase}");
      _filenames = [];
      
    }
    return _filenames;

  }

  static Future<List<String>> getAgreementFileList() async {
      
    try{
        // String ip=  await MySharedPreferences.instance.getIP();
 var _fileContent=[];
    List<String> _filenames = [];
     final response = await http.get(Uri.parse('http://$ip:8080/getAgreementFiles'));

    if (response.statusCode == 200) {
      _filenames = List<String>.from(json.decode(response.body));   
    } else {    
      print("Failed to load filenames: ${response.reasonPhrase}");
      _filenames = [];
      
    }
    return _filenames;
    }
    
    catch (e, stackTrace) {
    // Handle the error and log it if necessary
    print('Error: $e');
    print('Stack trace: $stackTrace');
  }
  return [];

  }

   static Future<String> getAffidavitFile(String filename,String dirname) async {
      // String ip=  await MySharedPreferences.instance.getIP();
    var _fileContent;
     Uri uri = Uri.parse('http://$ip:8080/file')
    .replace(queryParameters: {
      'fileName': filename,
      'dirName': dirname
    });
    // List<String> _filenames = [];
     final response = await http.get(uri);

    if (response.statusCode == 200) {
      if(kIsWeb){
       final blob = html.Blob([response.bodyBytes], 'application/pdf');

        // Create a Blob URL and open it in a new browser tab
        final pdfUrl = html.Url.createObjectUrlFromBlob(blob);
        html.window.open(pdfUrl, "_blank");

        // Optionally, revoke the blob URL after it's opened
        html.Url.revokeObjectUrl(pdfUrl);
        return "";
      }
      else{
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/downloaded.pdf');
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      }
   
    //  }
      
    } else {    
      print("Failed to load filenames: ${response.reasonPhrase}");
      // _fileContent = [];
      return "Failed to load filenames: ${response.reasonPhrase}";
      
    }
    
    // return _fileContent;

  }


     static Future<List<String>> getAgreementFile(String filename) async {
        String ip=  await MySharedPreferences.instance.getIP();
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