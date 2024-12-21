import 'package:aapka_vakeel/screens/trademark/trademarkDetail.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Trademark extends StatefulWidget {
  const Trademark({super.key});

  @override
  State<Trademark> createState() => _TrademarkState();
}

class _TrademarkState extends State<Trademark> {

 var  trademarkList=["Patent Registration",'Trademark Registration','Copyright Registration','Design Registration','Geographical Indication (GI) Registration','Trade Secret Protection','Plant Variety Protection','Integrated Circuit Layout Design Registration'];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:MyAppBar.appbar(context,head:'Trademark'),

      body: Container(
        child: getTrademarkList(),
      )
     
    );
  }

  getTrademarkList(){
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            height: MediaQuery.of(context).size.height-100,
            child: ListView.builder(
                                      itemCount: trademarkList.length,
                                      itemBuilder: (context, index) {
                                        return  
                                        GestureDetector(
                                          onTap: (){
                                            
                                            Navigator.push(
                                context,
                                PageTransition(
                                    child: TrademarkDetail(trademarkType: trademarkList[index],),
                                    type: PageTransitionType.rightToLeft));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Card(
                                              elevation: 4,
                                            color: Color(0xFFF0F0F0), // Sets the elevation to create shadow
                                            shadowColor: Colors.grey, // Sets shadow color to grey
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10), // Optional: Rounds the corners
                                            ),
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: [
                                                                          CustomText.RegularDarkText(trademarkList[index]),
                                                                    
                                                                        ]
                                                                      ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
          ),
        );
                  
  }
}