import 'dart:async';
import 'dart:ffi';

import 'package:aapka_vakeel/HTTP/serverhttpHelper.dart';
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
  bool isAffidavitPage=true;



  @override
  void initState() {
    super.initState();
    // affidavitList=await Serverhttphelper.getAffidavitFileList();
    // _filteredItems.addAll(_allItems);
  }

  void _filterItems(String query) {
    // List<String> results = [];
    // if (query.isEmpty) {
    //   results.addAll(_allItems);
    // } else {
    //   results = _allItems
    //       .where((item) => item.toLowerCase().contains(query.toLowerCase()))
    //       .toList();
    // }
    // setState(() {
    //   _filteredItems = results;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.appbar(context),
      body: Column(
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
                  onTap: () {
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
      height: MediaQuery.of(context).size.height-250,
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
              draftListContainer(" Address proof Affidavit"),
            ],
          ),
    );
  }
  

  agreementContainer(){
    return Container();
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
                            child: ContractLoader(),
                            type: PageTransitionType.rightToLeft));
      })
      ],),
    );
  }
}

class ContractLoader extends StatefulWidget {
   ContractLoader({super.key});

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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
          duration: Duration(milliseconds: 100),
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
              Image.asset(scrollWidgetContent[index]["imgPath"]),
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
          customButton.taskButton("Continue with Lawyer", (){}),
          SizedBox(height: 12),
          customButton.taskButton("Continue with AI", (){}),
        ],),
      ),
    );
  }
}