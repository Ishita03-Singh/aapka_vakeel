import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     

      body: Container(
        // padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CustomText.boldDarkText("Aapka Vakeel",fontSize: 40),
            SizedBox(height: 10),
            Container(height: 1,color: Colors.grey),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                  child: Row(crossAxisAlignment:CrossAxisAlignment.center ,
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(StrLiteral.mockup,width: MediaQuery.of(context).size.width/3,),
                      Container(
                        width: MediaQuery.of(context).size.width/3,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.cancelBtnText("Launching Soon!",fontsize: 35),
                            CustomText.RegularDarkText("In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is availabl",fontSize: 16),
                            SizedBox(height: 100),
                            CustomText.infoText("Download app from"),
                            SizedBox(height: 10),
                            Container(
                              // color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                customButton.playstoreButton(),
                                SizedBox(width: 10),
                                customButton.appStoreButton(),
                              
                              ],),
                            )
                                        
                                        
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
