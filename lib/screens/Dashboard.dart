import 'dart:async';

import 'package:aapka_vakeel/Utilities/strings.dart';
import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:aapka_vakeel/screens/OTPScreen.dart';
import 'package:aapka_vakeel/screens/affidavitScreen.dart';
import 'package:aapka_vakeel/screens/chatGPT/chatGPT.dart';
import 'package:aapka_vakeel/screens/consultation/consultation.dart';
import 'package:aapka_vakeel/screens/legalcases.dart';
import 'package:aapka_vakeel/screens/notaryScreen.dart';
import 'package:aapka_vakeel/screens/scbarContainer.dart';
import 'package:aapka_vakeel/screens/stampPaper.dart';
import 'package:aapka_vakeel/screens/trademark/trademark.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Dashboard extends StatefulWidget {
  User? user;
  UserClass? userclass;
  
   Dashboard({super.key, this.user,
  //  required this.userclass
  this.userclass
   });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

    OverlayEntry? _popupOverlay; // To store the overlay entry
  bool _isPopupVisible = false;
  //scroll widget variables
   final PageController _pageController = PageController();
   final PageController _LegalCasepageController = PageController();

   TextEditingController ipController= TextEditingController();
  int _currentPage = 0;
  Timer? _timer;
  bool _isVisible = false;
  //legal case
  int _legalCaseCurrentPage = 0;
  // Timer? _timer;
  bool __legalCaseCurrentPageisVisible = false;
  
  final List<Map> scrollLegalCases = [
    {
      "headText":"Legal cases",
      "infoText":"Solve your legal cases here",
      // "btnText":"Call now",
      "imagePath":StrLiteral.legalCase,
      "terms":false
    },
     {
      "headText":"Divorce cases",
      "infoText":"Get guidance on divorce case",
      // "btnText":"Call now",
      "imagePath":StrLiteral.divorce,
      "terms":true
    },
     {
      "headText":"Bail",
      "infoText":"Get easy guidance with bail",
      // "btnText":"Call now",
      "imagePath":StrLiteral.bail,
      "terms":true
    }
    ];
  final List<Map> scrollWidgetContent = [
    {
      "headText":"Are you in a legal dilemma?",
      "infoText":"Contact our lawyers now!",
      "btnText":"Call now",
      "imagePath":StrLiteral.slider1,
      "terms":false
    },
     {
      "headText":"Do you want to seek advice from a lawyer?",
      "infoText":"Price: Rs.x/min*",
      "btnText":"Call now",
      "imagePath":StrLiteral.slider2,
      "terms":true
    },
     {
      "headText":"Do you need a lawyer for your case?",
      "infoText":"",
      "btnText":"Contact now",
      "imagePath":StrLiteral.slider3,
      "terms":false
    },
     {
      "headText":"You focus on the business,",
      "infoText":"We can handle your legal needs",
      "btnText":"Contact now",
      "imagePath":StrLiteral.slider4,
      "terms":false
    }
      
    ];

   @override
  void initState() {
    super.initState();
     // Delay to show popup after 3 seconds
    //  _showPopup();
    Timer(Duration(seconds: 1),  _showPopup);
    Timer(Duration(seconds: 8),  _hidePopup);

    _startAutoScroll();
    _startAutoScrollLegalCases();
  }
  void _startAutoScrollLegalCases() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (__legalCaseCurrentPageisVisible) {
        if (_legalCaseCurrentPage < 2) {
          setState(() {
          _legalCaseCurrentPage++;
          });
        } else {
          setState(() {
          _legalCaseCurrentPage = 0; 
          });
        }
        _LegalCasepageController.animateToPage(
          _legalCaseCurrentPage,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }
 void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_isVisible) {
        if (_currentPage < 5) {
          setState(() {
          _currentPage++;
          });
        } else {
          setState(() {
          _currentPage = 0; 
          });
        }
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }
   @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }
  
  getScrollWigets(List<Map<dynamic,dynamic>> list,{isLegalCase=true}){
      return VisibilityDetector(
      key: isLegalCase?Key('horizontal-scrolling-divs-legalCase'):Key('horizontal-scrolling-divs'),
      onVisibilityChanged: (VisibilityInfo info) {
        if(isLegalCase){
     __legalCaseCurrentPageisVisible = info.visibleFraction > 0;
        }
        else{
           _isVisible = info.visibleFraction > 0;
        }
       
      },
      child: Container(
        height: 200.0, // Height of the horizontal scroll view
        child: PageView.builder(
          controller: isLegalCase? _LegalCasepageController:_pageController,
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(18,18,18,6),
              width: 150.0, // Width of each div
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF333333).withOpacity(0.2)),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
              Container(
                width: MediaQuery.of(context).size.width/2-80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CustomText.infoText(list[index]["headText"]),
                CustomText.RegularDarkText(list[index]["infoText"],fontSize: 13),
                SizedBox(height: 5),
                if(list[index]["btnText"]!=null)
                customButton.smalltaskButton(list[index]["btnText"], (){},radius: 24) 
                             ],),
              ),
              SizedBox(width: 8),
             Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                         //  crossAxisAlignment: CrossAxisAlignment.end,
             
               children: [
                 ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20)), 
                         child: Image.asset(list[index]["imagePath"],fit: BoxFit.fill,width: isLegalCase?200: 100,)),
               if(list[index]["terms"])
                CustomText.extraSmallinfoText("*Terms and conditions apply")
             
               ],
             ),
             ],
              ),
            );
          },
        ),
      ),
    );
  }




  // Function to create the popup overlay entry
  OverlayEntry _createPopupOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: 130, // Position it above the floating action button
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
               boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                  spreadRadius: 5, // How much the shadow spreads
                  blurRadius: 7,   // Softening of the shadow
                  offset: Offset(0, 3), // X and Y offset for the shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(onPressed: _hidePopup, icon: Icon(Icons.close,color: Colors.grey,size: 20,)),
                CustomText.RegularDarkText("Hi, Got any legal query? I’m happy to help.",fontSize: 12),
              ],
            )
          ),
        ),
      ),
    );
  }

  // Function to show the popup
  void _showPopup() {
    if (!_isPopupVisible) {
      _popupOverlay = _createPopupOverlay();
      Overlay.of(context)?.insert(_popupOverlay!);
      setState(() {
        _isPopupVisible = true;
      });
    }
  }

  // Function to hide the popup
  void _hidePopup() {
    if (_isPopupVisible) {
      _popupOverlay?.remove();
      setState(() {
        _isPopupVisible = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: 
       FloatingActionButton(
        shape: CircleBorder(),
        elevation: 10,
        backgroundColor: Colors.white,
        onPressed: (){
            setState(() {
                 _hidePopup();
                });
       
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: ChatScreen(),
                                    type: PageTransitionType.rightToLeft));
                            },
                            child:  Image.asset(StrLiteral.appLogoPath,width: 40,),),
      body: scrollContainer(),
      bottomNavigationBar: ScBar(),
    );
  }

  scrollContainer(){
    return SingleChildScrollView(
      child: 
         Container(
           child: Column(
             children: [
               MyAppBar.appbar(context),
               Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [ CustomText.headText("Welcome!"),
                  CustomText.infoText("How can we be of help?"),],
                  ),
                      Row(
                        children: [

                           GestureDetector(
                            onTap: (){},
                            child: Image.asset(StrLiteral.wallet,width: 30,),
                                            ),

                                            SizedBox(width: 10),
                          
                        ],
                      )
                    ],)
                ,
                   SizedBox(height: 10,),
                   Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Container(child:
                    getDashboardwidger(StrLiteral.affidavit,"Affidavit/Agreement","Get expert lawyer's signed Affidavit in minutes ",(){
                      _hidePopup();
                      Navigator.push(
                        context,
                        PageTransition(
                            child: AffidavitScreen(),
                            type: PageTransitionType.rightToLeft));}),
                    ),
                    SizedBox(width: 20,),
                    Container(child:
                    getDashboardwidger(StrLiteral.consultation,"Legal Consultation","Expert legal consultation is now just one call away",(){
                      _hidePopup();
                      Navigator.push(
                        context,
                        PageTransition(
                            child: ConsultLawyer(),
                            type: PageTransitionType.rightToLeft));
                    }),
                    )
                   ],)
                   , SizedBox(height: 20,),
                   Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Container(child:
                    getDashboardwidger(StrLiteral.notary,"Notary","Notary in three easy steps",(){
                      _hidePopup();
                       Navigator.push(
                        context,
                        PageTransition(
                            child: NotaryScreen(),
                            type: PageTransitionType.rightToLeft));
                    }),
                    ),
                    SizedBox(width: 20,),
                    Container(child:
                    getDashboardwidger(StrLiteral.stampPaper,"Stamp Paper","Get your stamp paper within minutes",(){
                      _hidePopup();
                       Navigator.push(
                        context,
                        PageTransition(
                            child: StampPaper(),
                            type: PageTransitionType.rightToLeft));
                    }),
                    )
                   ],),
                    SizedBox(height: 20,),
                  //  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //   Container(child:
                  //   getDashboardwidger(StrLiteral.GST,"GST","get queries related to gst solved at ease",(){}),
                  //   ),
                  //   SizedBox(width: 20,),
                  //   Container(child:
                  //   getDashboardwidger(StrLiteral.tradeMark,"Trademark","Get trademark and other facilities in simple steps",(){
                  //     Navigator.push(
                  //       context,
                  //       PageTransition(
                  //           child: Trademark(),
                  //           type: PageTransitionType.rightToLeft));
                  //   }),
                  //   )
                  //  ],),
                  SizedBox(height: 20),
                   GestureDetector(
                    onTap: (){
                                Navigator.push(
                                context,
                                PageTransition(
                                    child: LegalCases(),
                                    type: PageTransitionType.rightToLeft));
                    },
                     child: 
                     getScrollWigets(scrollLegalCases)
                   ),
                   SizedBox(height: 20),
                   getScrollWigets(scrollWidgetContent,isLegalCase: false),
                   
                   CustomText.headText("Recent Activities",color:Color(0xFF9C9999)),

                ],),
                       ),
             ],
           ),
         )
    );
  }





  getDashboardwidger(String img, String headText, String infoText,Function callFun ){
    var width=MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
   return GestureDetector(
    onTap: () {
      // AffidavitScreen
      callFun();
      
    },
     child: Expanded(
        // height: width>=height?MediaQuery.of(context).size.height/4:MediaQuery.of(context).size.height/3,
       child: Container(
        
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20),),
        border: Border.all(color: Color(0xFF333333).withOpacity(0.2),width: 1),
        color: Colors.white,
        boxShadow: [BoxShadow(
                      color: Color(0xFF333333).withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),] 
        ),
        child: Column(
          children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), 
            child: Image.asset(img,fit: BoxFit.cover,height: 140,width: MediaQuery.of(context).size.width/2-30,)),
          Container(
           width: MediaQuery.of(context).size.width/2-30,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              CustomText.smallheadText(headText),
              CustomText.extraSmallinfoText(infoText,isCenter: false),
            ],),
          )
        ],),
       ),
     ),
   );
  }
}
