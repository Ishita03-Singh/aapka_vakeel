import 'dart:async';
import 'package:aapka_vakeel/HTTP/serverhttpHelper.dart';
import 'package:aapka_vakeel/screens/affidavitFullScreen.dart';
import 'package:aapka_vakeel/screens/chatGPT/chatGPT.dart';
import 'package:aapka_vakeel/screens/notaryScreen.dart';
import 'package:aapka_vakeel/screens/scbarContainer.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AffidavitScreen extends StatefulWidget {
  const AffidavitScreen({super.key});

  @override
  State<AffidavitScreen> createState() => _AffidavitScreenState();
}

class _AffidavitScreenState extends State<AffidavitScreen> {
  TextEditingController _searchController = TextEditingController();
  // List<String> _allItems = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
  List<String> affidavitList = [];
  List<String> agreementList = [];
  bool isAffidavitPage=true;
  List<String> _filteredItems=[];

  @override
  void initState() {
    super.initState();
    _initializeAsync();
  }

Future<void> _initializeAsync() async {
  List<String> affidavitlist=await Serverhttphelper.getAffidavitFileList();
    setState(() {
      affidavitlist = affidavitlist;
    });
     _filteredItems.addAll(affidavitList);
  }
  void _filterItems(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results.addAll(affidavitList);
    } else {
      results = affidavitList
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.appbar(context),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: GestureDetector(
                    onTap: ()async{
                      affidavitList= await Serverhttphelper.getAffidavitFileList();
                      setState(() {
                      isAffidavitPage=true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color:Colors.black),
                        color: isAffidavitPage?Colors.black:Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: isAffidavitPage?CustomText.taskBtnText("Affidavit"):CustomText.cancelBtnText("Affidavit")),
                  )),
                  SizedBox(width: 40),
                  Expanded(child: GestureDetector(
                      onTap: ()async {
                        agreementList= await Serverhttphelper.getAgreementFileList();
                        setState(() {
                          isAffidavitPage=false;
                        });
                      },
                      child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color:Colors.black),
                        color: isAffidavitPage?Colors.white:Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: isAffidavitPage?CustomText.cancelBtnText("Agreement"):CustomText.taskBtnText("Agreement"),),
                    )),
                // customButton.taskButton("Affidavit", (){
                //   setState(() {
                //     isAffidavitPage=true;
                //   });
                // }),
                // customButton.cancelButton("Agreement", (){
                //   setState(() {
                //     isAffidavitPage=false;
                //   });
                // })
              ],),
            ),
            isAffidavitPage?affidavitContainer():agreementContainer()
          ],),
        ),
      ),
      bottomNavigationBar: ScBar(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
   
  affidavitContainer(){
    return Container(
      height: MediaQuery.of(context).size.height-200,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                onChanged: _filterItems,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  labelText: 'Search..',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    // borderSide: ,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: _filteredItems.length,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         title: Text(_filteredItems[index]),
              //       );
              //     },
              //   ),
              // ),
              IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
                 Container(
                   height: MediaQuery.of(context).size.height-320,
                   width: MediaQuery.of(context).size.width,
                   child: ListView.builder(
                    itemCount: affidavitList.length,
                    itemBuilder: (context, index) {
                    return  draftListContainer(affidavitList[index]);
                     },
                                  ),
                 ),
              // draftListContainer(" Address proof Affidavit"),
            ],
          ),
    );
  }
  

  agreementContainer(){
     return Container(
      height: MediaQuery.of(context).size.height-200,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                onChanged: _filterItems,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  labelText: 'Search..',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    // borderSide: ,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: _filteredItems.length,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         title: Text(_filteredItems[index]),
              //       );
              //     },
              //   ),
              // ),
              IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
              Container(
                   height: MediaQuery.of(context).size.height-320,
                   width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: agreementList.length,
                    itemBuilder: (context, index) {
                    return  draftListContainer(agreementList[index]);
                     },
                 ),
              ), 
            ],
          ),
    );
  }

  draftListContainer(String text,){
    return Container(
      margin: EdgeInsets.only(top:  6),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFF0F0F0),
        borderRadius: BorderRadius.all(Radius.circular(10))
        ),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [CustomText.RegularDarkText(text,fontSize: 16),
      customButton.smalltaskButton("Details", (){
        Navigator.push(
                        context,
                        PageTransition(
                            child: ContractLoader(fileName:text,isAffidavitPage: isAffidavitPage,),
                            type: PageTransitionType.rightToLeft));
      })
      ],),
    );
  }
}

class ContractLoader extends StatefulWidget {
   String fileName;
   bool isAffidavitPage;
   ContractLoader({super.key,required this.fileName,required this.isAffidavitPage});

  @override
  State<ContractLoader> createState() => _ContractLoaderState();
}

class _ContractLoaderState extends State<ContractLoader> {
  bool aiGenerated=true;
  Timer? _timer;
  int _currentPage = 0;
   final PageController _pageController = PageController();
   final List<Map> scrollWidgetContent = [
    {
      "type":"It’s Free",
      "imgPath":StrLiteral.aiDrafts,
      "headText":"Contracts made simple with AI",
      "infoText":"*we are not responsible for any draft",
    
    },
    {
      "type":"Recommended",
      "imgPath":StrLiteral.lawyerDrafts,
      "headText":"Expert Contracts by the Lawyer",
      "infoText":"",
      
    }
    ];
    
List<String> affidavitList= [];


@override
  void initState() {
    // TODO: implement initState
    super.initState();
     _startAutoScroll();
    
  }
   void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // if (_isVisible) {
        if (_currentPage < 1) {
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
      // }
    });
  }
     @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20,40,20,20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Expanded(
            child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: (context, index) {
              return Container(
              padding:EdgeInsets.all(20),
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(              
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              CustomText.smallheadText(scrollWidgetContent[index]["type"]),
              Image.asset(scrollWidgetContent[index]["imgPath"],height: MediaQuery.of(context).size.height/2,),
              CustomText.headText(scrollWidgetContent[index]["headText"]),
              SizedBox(height: 10),
              if(scrollWidgetContent[index]["infoText"]!="")
              CustomText.extraSmallinfoText(scrollWidgetContent[index]["infoText"])
            ],),
            );
          }
            
            
          ),),
          SizedBox(height: 12),
          Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            width: 25,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                              color: _currentPage==0?Colors.black:Color(0xFFbdbdbd),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.all(5),
                            width: 25,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                              color: _currentPage==0?Color(0xFFbdbdbd):Colors.black,
                            ),
                          ),
          ],),
          SizedBox(height: 12),
          customButton.taskButton("Continue with Lawyer", ()async{

            String dir= widget.isAffidavitPage?"Affidavit":"Agreements";
            String draftfile=await Serverhttphelper.fetchFileUrl(widget.fileName,dir);

            Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: NotaryScreen(filePath:draftfile),
                        type: PageTransitionType.rightToLeft));
          }),
          SizedBox(height: 12),
          customButton.taskButton("Continue with AI", (){
               Navigator.push(
                    context,
                    PageTransition(
                        child: ChatScreen(prompt:"Generate a affidavit for name change"),
                        type: PageTransitionType.rightToLeft));
          }),
        ],),
      ),
    );
  }
}