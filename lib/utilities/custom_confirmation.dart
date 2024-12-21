import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:flutter/material.dart';

class ConfirmDialog{
  static void showLogoutConfirmationDialog(BuildContext context,Function fun,String text,String funName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText.RegularDarkText(text),
          actions: [
            customButton.smalltaskButton("Cancel",(){
              Navigator.of(context).pop(); // Close the dialog
            }),
            customButton.textButton(funName,()async{  
              Navigator.of(context).pop(); // Close the dialog
                await fun(); // Sign out the user
            })
            
          ],
        );
      },
    );
  }

}