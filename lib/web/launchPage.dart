import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Container(
        child:Center(child: CustomText.boldDarkText("Launching soon....",fontSize: 65)) ,
      ),
    );
  }
}