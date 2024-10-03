import 'dart:html' as html;
import 'dart:io';

import 'package:aapka_vakeel/model/advocate.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
class Serverhttphelper{
  
  // static String ip="192.168.1.34";
  static Future<List<String>> getAffidavitFileList() async {
  try {
      // Firebase Storage instance
      FirebaseStorage storage = FirebaseStorage.instance;

      // Reference to the folder where the files are stored (adjust the folder path accordingly)
      Reference ref = storage.ref().child('Affidavit');

      // List all files in the 'agreements' folder
      ListResult result = await ref.listAll();

      // Get the download URLs for each file
      List<String> _fileUrls = [];
       List<String> _fileNames = [];
      for (var item in result.items) {
        String fileName = item.name;  // Get the file name
        _fileNames.add(fileName);
      }

      return _fileNames;  // Return the list of file names
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return [];  // Return an empty list in case of error
    }

  }

  static Future<List<String>> getAgreementFileList() async {
      
   try {
      // Firebase Storage instance
      FirebaseStorage storage = FirebaseStorage.instance;

      // Reference to the folder where the files are stored (adjust the folder path accordingly)
      Reference ref = storage.ref().child('Agreements');

      // List all files in the 'agreements' folder
      ListResult result = await ref.listAll();

      // Get the download URLs for each file
      List<String> _fileUrls = [];
       List<String> _fileNames = [];
      for (var item in result.items) {
        String fileName = item.name;  // Get the file name
        _fileNames.add(fileName);
      }

      return _fileNames;  // Return the list of file names // Return the list of URLs
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return [];  // Return an empty list in case of error
    }
  }

  //  static Future<String> getAffidavitFile(String filename,String dirname) async {
  //     String ip=  await MySharedPreferences.instance.getIP();
  //   var _fileContent;
  //    Uri uri = Uri.parse('http://$ip:8080/file')
  //   .replace(queryParameters: {
  //     'fileName': filename,
  //     'dirName': dirname
  //   });
  //   // List<String> _filenames = [];
  //    final response = await http.get(uri);

  //   if (response.statusCode == 200) {
  //     if(kIsWeb){
  //      final blob = html.Blob([response.bodyBytes], 'application/pdf');

  //       // Create a Blob URL and open it in a new browser tab
  //       final pdfUrl = html.Url.createObjectUrlFromBlob(blob);
  //       html.window.open(pdfUrl, "_blank");

  //       // Optionally, revoke the blob URL after it's opened
  //       html.Url.revokeObjectUrl(pdfUrl);
  //       return "";
  //     }
  //     else{
  //       final dir = await getApplicationDocumentsDirectory();
  //       final file = File('${dir.path}/downloaded.pdf');
  //       await file.writeAsBytes(response.bodyBytes);
  //       return file.path;
  //     }
   
  //   //  }
      
  //   } else {    
  //     print("Failed to load filenames: ${response.reasonPhrase}");
  //     // _fileContent = [];
  //     return "Failed to load filenames: ${response.reasonPhrase}";
      
  //   }
    
  //   // return _fileContent;

  // }


  //    static Future<List<String>> getAgreementFile(String filename) async {
  //       String ip=  await MySharedPreferences.instance.getIP();
  //   var _fileContent;
  //   // List<String> _filenames = [];
  //   Uri uri = Uri.parse('http://$ip:8080/file')
  //   .replace(queryParameters: {
  //     'fileName': filename,
  //     'dirName': 'AgreementDocument' 
  //   });
  //    final response = await http.get(uri);

  //   if (response.statusCode == 200) {
  //     _fileContent = response.body;   
  //   } else {    
  //     print("Failed to load filenames: ${response.reasonPhrase}");
  //     _fileContent = new File("");
      
  //   }
  //   return _fileContent;

  // }

  static Future<void> uploadFile(pickedFile) async {
  // Picking an image (or you can use File picker)
  // final picker = ImagePicker();
  // final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    File file = File(pickedFile.path);

    try {
      // Uploading file to Firebase Storage
      String fileName = 'uploads/${DateTime.now()}.png';
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(file);

      // Waiting for the upload to complete
      await uploadTask.whenComplete(() {
        print('File uploaded!');
      });

      // Getting the download URL of the uploaded file
      String downloadUrl = await ref.getDownloadURL();
      print('File URL: $downloadUrl');
    } catch (e) {
      print('Error uploading file: $e');
    }
  } else {
    print('No file selected.');
  }
}


static Future<String> fetchFileUrl(String filename,String dirname) async {
    try {
      // Firebase Storage reference to the file path
      FirebaseStorage storage = FirebaseStorage.instance;
      String filePath = '/$dirname/$filename'; // Replace with your file path

      // Get the download URL for the file
      String downloadUrl = await storage.ref(filePath).getDownloadURL();

      // setState(() {
      var  _downloadUrl = downloadUrl;
      // });
return _downloadUrl;
      // print('Download URL: $downloadUrl');  // Check the URL in console
    } catch (e) {
      print('Error fetching download URL: $e');
    }
    return "";
  }



}
