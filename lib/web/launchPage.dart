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
            // Row(mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset(StrLiteral.appLogoPath,width: 80),
            //     SizedBox(width: 10),
            //     CustomText.boldDarkText("Aapka Vakeel",fontSize: 40),
            //   ],
            // ),
            // SizedBox(height: 10),
            // Container(height: 1,color: Colors.grey),
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
                            CustomText.RegularDarkText("Stay connected to legal experts anytime, anywhere. Experience seamless legal support from affidavits to consultations right from your phone.",fontSize: 16),
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
