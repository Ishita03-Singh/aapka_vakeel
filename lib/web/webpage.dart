import 'dart:async';

import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/screens/firebasedemo.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:aapka_vakeel/web/PrivacyPolicy.dart';
import 'package:aapka_vakeel/web/TermsAndCondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Webpage extends StatefulWidget {
    static const String routeName = '/';
  UserClass? userclass;
  Webpage({super.key, this.userclass});

  @override
  State<Webpage> createState() => _WebpageState();
}

class _WebpageState extends State<Webpage> {
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
    }];
      int _currentPage = 0;
  Timer? _timer;
  bool _isVisible = false;
     final PageController _pageController = PageController();

    @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.all(12),
          child: Column(
            children: [
              loginSection(),
              navigationRoutes(),
              getScrollWigets(),
              CustomText.RegularDarkText("TRUSTED BY USERS ALL OVER INDIA",fontSize: 14),
              SizedBox(height: 10),
              widgetSection(),
             SizedBox(height: 20),
             faqSection(),
             footerSection(),
             SizedBox(height: 10),
             Container(height: 1,color:Colors.black),
             SizedBox(height: 10),
             CustomText.RegularDarkText("2023-24 © Aapka Vakeel Pvt. Ltd. | All Rights Reserved",fontSize: 12),
             SizedBox(height: 10),
             
            ],
          ),
        ),
      ),
    );
  }
getScrollWigets(){
      return VisibilityDetector(
      key: Key('horizontal-scrolling-divs'),
      onVisibilityChanged: (VisibilityInfo info) {
        _isVisible = info.visibleFraction > 0;
      },
      child: Container(
        height: 200.0, // Height of the horizontal scroll view
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: scrollWidgetContent.length,
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CustomText.infoText(scrollWidgetContent[index]["headText"]),
                CustomText.RegularDarkText(scrollWidgetContent[index]["infoText"]),
                SizedBox(height: 5),
                customButton.smalltaskButton(scrollWidgetContent[index]["btnText"], (){},radius: 24) 
                             ],),
              ),
              SizedBox(width: 8),
             Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                         //  crossAxisAlignment: CrossAxisAlignment.end,
             
               children: [
                 ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20)), 
                         child: Image.asset(scrollWidgetContent[index]["imagePath"],fit: BoxFit.fill,)),
               if(scrollWidgetContent[index]["terms"])
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
  
  loginSection(){
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Image.asset(StrLiteral.appLogoPath,width: 150),
        Row(children: [
          Image.asset(StrLiteral.profile,width: 30),
          SizedBox(width: 10),
          CustomText.RegularDarkText(widget.userclass==null?"Login/SignUp":widget.userclass!.displayName)
        ],)

      ],),
    );
  }

  navigationRoutes(){
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
      CustomText.smallheadText("Affidavit/Agreement"),
      SizedBox(width: 15),
      CustomText.smallheadText("Legal Consultation"),
      SizedBox(width: 15),
      CustomText.smallheadText("Notary"),
      SizedBox(width: 15),
      CustomText.smallheadText("Stamp Paper"),

    ],);
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
  widgetSection(){
    return Container(
      padding: EdgeInsets.all(40),
     child:Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.appNameText("OUR SERVICES"),
        SizedBox(height: 20),
        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(child:
                    getDashboardwidger(StrLiteral.affidavit,"Affidavit/Agreement","Lorem Ipsum is simply dummy ",(){
                      // Navigator.push(
                        // context,
                        // PageTransition(
                        //     child: AffidavitScreen(),
                        //     type: PageTransitionType.rightToLeft));
                        }),
                    ),
                    SizedBox(width: 20,),
                    Expanded(child:
                    getDashboardwidger(StrLiteral.consultation,"Legal Consultation","Lorem Ipsum is simply dummy ",(){}),
                    )
                   ],),
                   SizedBox(height: 20),
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(child:
                    getDashboardwidger(StrLiteral.affidavit,"Notary","Lorem Ipsum is simply dummy ",(){
                      // Navigator.push(
                        // context,
                        // PageTransition(
                        //     child: AffidavitScreen(),
                        //     type: PageTransitionType.rightToLeft));
                        }),
                    ),
                    SizedBox(width: 20,),
                    Expanded(child:
                    getDashboardwidger(StrLiteral.stampPaper,"Stamp paper","Lorem Ipsum is simply dummy ",(){}),
                    )
                   ],)
      ],
     ) ,
    );
  }
  getDashboardwidger(String img, String headText, String infoText,Function callFun ){
   return GestureDetector(
    onTap: () {
      // AffidavitScreen
      callFun();
      
    },
     child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: Color(0xFF333333).withOpacity(0.2),width: 1),
      color: Colors.white,
      boxShadow: [BoxShadow(
                    color: Color(0xFF333333).withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),] 
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), 
          child: Image.asset(img,fit: BoxFit.fill,height: 140,)),
        Container(
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
   );
  }
  
  faqSection(){
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.black,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                   
                    child:   CustomText.taskBtnText("FAQ’s",fontsize: 65),
                  ),
                ),
              )
          ,
            Expanded(
              child: Container(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                getExpansionWidget("Are your online lawyers qualified?","Yes, the advocates on our app are highly qualified professionals registered under the Bar Council of India. Each lawyer holds at least an LLB or BALLB degree, meeting the necessary qualifications for Bar registration in India. They also provide details about their years of experience, specialties, and background to help you select the most suitable professional for your needs."),
                getExpansionWidget("How do I choose a lawyer on the app?","When you access the Legal Consultation section, you’ll see a selection of advocates at random, each displaying the details necessary to make an informed choice about your legal consultant, as permitted by the Bar Council of India (BCI) guidelines. While specific advocate names aren’t searchable, you can filter based on experience, specialization, and the type of service you’re seeking. Additionally, you may enter keywords related to your legal needs to find the most suitable professional."),
                getExpansionWidget("Is my personal information safe on this app?", "Yes, your privacy and confidentiality are our top priorities. All advocates on our platform follow strict attorney-client privilege rules, ensuring that no information shared between you and your lawyer is disclosed to anyone else. Our app has a comprehensive Privacy Policy to protect your data. Any necessary data storage is done securely, strictly to manage issues such as misconduct reporting and service improvements. We take all steps to maintain confidentiality and prevent unauthorized access to your information."),
                getExpansionWidget("What happens if I don't get a response from a lawyer within 24 hours?", "After booking a consultation, you should receive a response from your chosen lawyer within 24 hours. If, however, you don’t receive a response within this time frame, you have three options:\n1. Rebook with the same advocate and wait for a response within another 24 hours.\n2. Choose a different advocate from the Legal Consultation section, who will respond within 24 hours of booking.\n3. Select the option to have an assigned advocate reach out to you. In this case, an advocate with matching credentials will contact you within 6-8 hours, saving you time and effort in finding another suitable lawyer."),
                getExpansionWidget("Can I consult with more than one lawyer if I have multiple legal questions?", "Absolutely. You’re welcome to consult with as many advocates as you wish, whether it’s for a single issue or multiple questions, until you feel fully informed and satisfied. We also encourage you to explore offline or external consultations to ensure that you find the best service for your needs. Our goal is to support fair competition and provide you with the flexibility to compare options and choose what works best for you."),
                getExpansionWidget("Can I cancel a booked consultation, and is there a refund policy?", "Yes, you can cancel a consultation as long as it’s before the advocate contacts you, which will be within 24 hours of booking. Since charges are based on a per-minute call basis, you will not be billed if the consultation hasn’t started."),
                getExpansionWidget("Are there any restrictions on the types of cases or issues I can discuss with a lawyer through the app?", "No, there are no restrictions. Our app features a diverse range of lawyers ready to handle various types of cases and legal issues, just like in real life. You can seek consultation on any legal matter you wish to discuss.")  ,
                getExpansionWidget("What should I do if I am not satisfied with the consultation?", "If you are not satisfied with your consultation, you can communicate your concerns directly to the advocate. In real life, it's important to discuss any issues openly, as this may lead to a resolution. If needed, you can also explore consulting another advocate through the app to find someone who better meets your needs."),
                getExpansionWidget("How can I ensure that my information remains confidential when using the app?", "Your confidentiality is protected by the principle of attorney-client privilege. Additionally, our app has a comprehensive privacy policy that outlines how your information is handled. We encourage users to read this policy if they have any concerns about data privacy and security.")
                  
                  ],
                ),
              ),
            )
          ],),
          CustomText.taskBtnText("or mail us on customercare@gmail.com")
        ],
      ),
    );
  }
  getExpansionWidget( String title, String childText){
  return     
    ExpansionTile(
    title:
        Align(
        alignment: Alignment.centerLeft,
        child: CustomText.taskBtnText(title,fontsize: 14,align: TextAlign.left),
        ),
        children: [
          ListTile(contentPadding: EdgeInsets.symmetric(horizontal: 32.0),
                title: Align(
                  alignment: Alignment.centerLeft,
                  child:  CustomText.taskBtnText(childText,fontsize: 12,align: TextAlign.left)
                )),
                     ],);
                   
  }

  footerSection(){
    return
    Container(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(StrLiteral.appLogoPath,width: 100,),
          Container(
            padding: EdgeInsets.all(40),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
         SizedBox(width: 50),
          Container(
            width: MediaQuery.of(context).size.width/4,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText.boldinfoText("SUPPORT"),
                SizedBox(height: 20),
                Row(children: [
                  Icon(Icons.call_outlined),
                  SizedBox(width: 5),
                  CustomText.RegularDarkText("+93145XXXXX",fontSize: 16),
                ],),
                SizedBox(height: 10),
                  Row(children: [
                  Icon(Icons.mail_outline),
                  SizedBox(width: 5),
                  CustomText.RegularDarkText("info@apkavakeel.com",fontSize: 16),
                ],),
                SizedBox(height: 10),
                Row(children: [
                  Icon(Icons.message_outlined),
                  SizedBox(width: 5),
                  CustomText.RegularDarkText("WhatsApp",fontSize: 16),
                ],)
            
              ],
            ),
          ),
          SizedBox(width: 50),
           Container(
            width: MediaQuery.of(context).size.width/4,
             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText.boldinfoText("COMPANY"),
                SizedBox(height: 20),
                CustomText.RegularDarkText("About",fontSize: 16),
                SizedBox(height: 10),
                CustomText.RegularDarkText("Contact us",fontSize: 16),
                SizedBox(height: 10),
                CustomText.RegularDarkText("Advisors",fontSize: 16),
                SizedBox(height: 10),
                CustomText.RegularDarkText("Careers",fontSize: 16),
                 SizedBox(height: 10),
                CustomText.RegularDarkText("Blogs",fontSize: 16),
              ],
                       ),
           ),
          SizedBox(width: 50),
           Container(
            width: MediaQuery.of(context).size.width/4,
             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText.boldinfoText("LEGAL"),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                     Navigator.push(
                        context,
                        PageTransition(
                            child: Privacypolicy(),
                            type: PageTransitionType.rightToLeft));
                  },
                  child: CustomText.RegularDarkText("Privacy Policy",fontSize: 16)),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: (){
                     Navigator.of(context).pushNamed(TermsAndCondition.routeName);
                    //  Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         child: TermsAndCondition(),
                    //         type: PageTransitionType.rightToLeft));
                            },
                  child: CustomText.RegularDarkText("Terms of use",fontSize: 16)),
                SizedBox(height: 10),
                CustomText.RegularDarkText("AapkaVakeel Cash terms",fontSize: 16),
             
              ],
                       ),
           )
          
              ],
            ),
          )
         
        ],
      ),
    );
  }
}