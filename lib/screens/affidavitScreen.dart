import 'dart:async';
import 'package:aapka_vakeel/HTTP/serverhttpHelper.dart';
import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/screens/affidavitFullScreen.dart';
import 'package:aapka_vakeel/screens/chatGPT/chatGPT.dart';
import 'package:aapka_vakeel/screens/notaryScreen.dart';
import 'package:aapka_vakeel/screens/scbarContainer.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/cutom_message.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:aapka_vakeel/utilities/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call/video_call.dart';

import '../others/locationService.dart';
import '../utilities/colors.dart';
import '../utilities/my_textfield.dart';

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
  // List<String> affidavitlist=await Serverhttphelper.getAffidavitFileList();
    affidavitList= await Serverhttphelper.getAffidavitFileList();
    setState(() {
      isAffidavitPage=true;
    });
     _filteredItems= affidavitList;
     _searchController.addListener(_affidavitFilterItems);
  }
  void _affidavitFilterItems() {
     String query = _searchController.text.toLowerCase();
    
    setState(() {
      _filteredItems = affidavitList.where((item) {
        return item.toLowerCase().contains(query);
      }).toList();
    });
  }
   void _agreementFilterItems() {
     String query = _searchController.text.toLowerCase();
    
    setState(() {
      _filteredItems = agreementList.where((item) {
        return item.toLowerCase().contains(query);
      }).toList();
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
                      _filteredItems=affidavitList;
                      _searchController.removeListener(_agreementFilterItems);
                      _searchController.addListener(_affidavitFilterItems);
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
                  SizedBox(width: 20),
                  Expanded(child: GestureDetector(
                      onTap: ()async {
                        agreementList= await Serverhttphelper.getAgreementFileList();
                        setState(() {
                          isAffidavitPage=false;
                          _filteredItems=agreementList;
                           _searchController.removeListener(_affidavitFilterItems);
                          _searchController.addListener(_agreementFilterItems);
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
                // onChanged: _filterItems,
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
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                    return  draftListContainer(_filteredItems[index].split(".")[0]);
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
                // onChanged: _filterItems,
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
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                    return  draftListContainer(_filteredItems[index].split('.')[0]);
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
      children: [
      Container(child: CustomText.RegularDarkText(text,fontSize: 16),width: MediaQuery.of(context).size.width/1.8),
      customButton.smalltaskButton("Details", (){
        //getDetailPage
        Navigator.push(
                        context,
                        PageTransition(
                            child: AffidavitDetail(fileName:text,isAffidavitPage: isAffidavitPage,),
                            type: PageTransitionType.rightToLeft));
      })
      ],),
    );
  }
}

class AffidavitDetail extends StatefulWidget {
  String fileName;
  bool isAffidavitPage;
  AffidavitDetail({super.key,required this.fileName, required this.isAffidavitPage});

  @override
  State<AffidavitDetail> createState() => _AffidavitDetailState();
}

class _AffidavitDetailState extends State<AffidavitDetail> {
   final _formKey = GlobalKey<FormState>();

TextEditingController nameController= new TextEditingController();
TextEditingController fatherNameController= new TextEditingController();
TextEditingController addressController= new TextEditingController();
TextEditingController stateController= new TextEditingController();
TextEditingController cityController= new TextEditingController();
TextEditingController CountryController= new TextEditingController();
TextEditingController PinCodeController= new TextEditingController();


bool _isLoaderVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.appbar(context,head: widget.fileName.split('.')[0]),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.amberAccent,
          height: MediaQuery.of(context).size.height-100,
          padding: EdgeInsets.all(12),
          child :getSinglePartyForm()
        ),
      ),
    );
  }
  Future<bool> requestLocationPermission() async {
  // Check if location permission is granted
  var status = await Permission.location.status;
  
  if (status.isDenied) {
    // Request location permission
    status = await Permission.location.request();
    
    if (status.isGranted) {
      // Permission granted, get the location
      return true;
    
    } else if (status.isPermanentlyDenied) {
      return false;
      
    }
  } else if (status.isGranted) {
    return true;
  }
  return false;
}

  getSinglePartyForm(){
 

return Container(
  padding: EdgeInsets.only(top: 10),
  child: Form(
    key: _formKey,
    child: 
    SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
          CustomText.infoText("Kindly fill the details required and proceed"),
          SizedBox(height: 40),
          giveInputField("Name", nameController, true,TextInputType.name),
          giveInputField("Father Name", fatherNameController, true,TextInputType.name),
          customButton.cancelButton("Get location", () async {
            bool permission = await requestLocationPermission();
            if (permission) {
              context.loaderOverlay.show();
              setState(() {
                _isLoaderVisible = context.loaderOverlay.visible;
              });
              
              try {
                // Check if location services are enabled
                bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
                if (!isLocationServiceEnabled) {
                  CustomMessenger.defaultMessenger(context, "Location services are disabled. Please enable them.");
                  await Geolocator.openLocationSettings();
                  return; // Exit the function if location services are disabled
                }
      
              var location = await LocationService.getCityAndState();
              setState(() {
                cityController.text = location['city'] ?? '';
                stateController.text = location['state'] ?? '';
                //  pincode.text= location['pincode']??'';
              });
            } catch (e) {
              print("Error: $e");
            } finally {
              if (_isLoaderVisible && context.mounted) {
                context.loaderOverlay.hide();
              } else {
                CustomMessenger.defaultMessenger(context, "Did not get Permission");
              }
            }

            setState(() {
              _isLoaderVisible = context.loaderOverlay.visible;
            });
          } else {
            CustomMessenger.defaultMessenger(context, "Location permission not granted.");
          }
        }),
          SizedBox(height: 8),
          getStateCityInput(),
          giveInputField("Address", addressController, true,TextInputType.streetAddress),
          giveInputField("Pin code", PinCodeController, true,TextInputType.number),

          // giveInputField("State", stateController, true,TextInputType.text),
          // giveInputField("City", cityController, true,TextInputType.text),
         
            customButton.taskButton("Continue", (){
      
           if (_formKey.currentState!.validate()) {
            var details={
              "Name": nameController.text,
              "FatherName":fatherNameController.text,
              "Address":addressController.text+", "+cityController.text+", "+stateController.text+", "+CountryController.text+', '+PinCodeController.text
            };
              Navigator.of(context).pushReplacement(
                   MaterialPageRoute(
                    builder: (context) =>ContractLoader(fileName:widget.fileName,isAffidavitPage: widget.isAffidavitPage,DocumentDetails:details)
                    // VideoCall(data: snapshot.data!),
                    ),
                                                                  );
            }
              else{
              return false;
              }
            } ),
      
                  // PaymentGateway paymentGateway = new PaymentGateway(context,  {
              //             'key': 'rzp_live_ILgsfZCZoFIKMb',
              //             'amount': 4045,//the amount is in points like 40.45
              //             'name': 'Acme Corp.',
              //             'description': 'Fine T-Shirt',
              //             'retry': {'enabled': true, 'max_count': 1},
              //             'send_sms_hash': true,
              //             'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
              //             'external': {
              //               'wallets': ['paytm']
              //             }
              //           }); 
            ],
        ),
    )),
);
  }
  


  getStateCityInput(){
    return   CSCPicker(
                  // disableCountry:true,
                  defaultCountry:CscCountry.India,
                  currentCountry: CscCountry.India.toString(),
                  showCities: true,
                  showStates: true,
                   dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border:
                      Border.all(color: Colors.grey.shade300, width: 1)),

                  ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.shade300,
                      border:
                      Border.all(color: Colors.grey.shade300, width: 1)),
                  stateSearchPlaceholder: "State",
                  citySearchPlaceholder: "City",
                  stateDropdownLabel: "State",
                  cityDropdownLabel: "City",
                
                  selectedItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  dropdownHeadingStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),

                  dropdownItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  ///Dialog box radius [OPTIONAL PARAMETER]
                  dropdownDialogRadius: 10.0,

                  onCountryChanged: (value) {
                    setState(() {
                      ///store value in state variable
                      // var t=value.split('   ');
                      // print("part:"+t.toString()+" ");
                      CountryController.text = value.split('    ')[1]??'';
                      // print(countryController.text);
                    });
                  },
                  ///Search bar radius [OPTIONAL PARAMETER]
                  searchBarRadius: 10.0,
                  onStateChanged: (value) {
                    setState(() {
                      ///store value in state variable
                      stateController.text = value??'';
                    });
                  },

                  ///triggers once city selected in dropdown
                  onCityChanged: (value) {
                    setState(() {
                      ///store value in city variable
                      cityController.text = value??'';
                    });
                  },
                );

  }

  giveInputField(
      String HeadText, TextEditingController controller, bool isrequired, TextInputType textInputType) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              if (isrequired)
                Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                ),
              Padding(padding: EdgeInsets.all(4)),
              CustomText.infoText(HeadText),
            ],
          ),
          TextFormField(
              decoration: MyTextField.outlinedTextField(""),
              keyboardType: textInputType,
              controller: controller,
              // readOnly: true,
               validator: (value) {
                 validationService.validate(value!, textInputType);
                },
              // enabled: true,
              // enableInteractiveSelection: false,
              cursorColor: AppColor.primaryTextColor,
              style: TextStyle(
                  color: AppColor.primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
  
}


class ContractLoader extends StatefulWidget {
   String fileName;
   bool isAffidavitPage;
   var DocumentDetails;
   ContractLoader({super.key,required this.fileName,required this.isAffidavitPage,required this.DocumentDetails});

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
      appBar: MyAppBar.appbar(context,head: ""),
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
            // String fileName;
            // bool isAffidavitPage;
            // var DocumentDetails;
            
 


             Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: AdvocateAffidavitDetails(fileName:widget.fileName,isAffidavitPage:widget.isAffidavitPage,DocumentDetails:widget.DocumentDetails),
                        type: PageTransitionType.rightToLeft));
           
          }),
          SizedBox(height: 12),
          customButton.taskButton("Continue with AI", (){
               Navigator.push(
                    context,
                    PageTransition(
                        child: ChatScreen(prompt:"Generate a ${widget.isAffidavitPage?"affidavit":"agreement"} for ${widget.fileName.split('.')[0]} and fill these  details, name:${widget.DocumentDetails["Name"]}, father name: ${widget.DocumentDetails["FatherName"]}, address:${widget.DocumentDetails["Address"]}"),
                        type: PageTransitionType.rightToLeft));
          }),
        ],),
      ),
    );
  }
}

class AdvocateAffidavitDetails extends StatefulWidget {
  String fileName;
  bool isAffidavitPage;
  var DocumentDetails;

   AdvocateAffidavitDetails({super.key,required this.isAffidavitPage,required this.DocumentDetails,required this.fileName});

  @override
  State<AdvocateAffidavitDetails> createState() => _AdvocateAffidavitDetailsState();
}

class _AdvocateAffidavitDetailsState extends State<AdvocateAffidavitDetails> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.fileName=widget.fileName.split('.')[0];
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar.appbar(context,head: widget.fileName),
      body:
      //  SingleChildScrollView(
        // child: 

        Container(
          height: MediaQuery.of(context).size.height-100,
          padding: EdgeInsets.all(12),
          child: Column( crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              getNamePriceContainer(),
              SizedBox(height: 30),
              CustomText.smallheadText("Benefits"),
              SizedBox(height: 10),
             RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "1. Ensures the distribution of the property\n",
            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
          ),
          TextSpan(
            text: "2. Provides financial security\n",
            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
          ),
          TextSpan(
            text: "3. Appointing guardian for minors.\n",
            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
          ),
          TextSpan(
            text: "4. Inventory of assets\n",
            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
          ),
          TextSpan(
            text: "5. Reduces legal hassles",
            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
          ),
        ],
      ),
    ),   
           
            SizedBox(height: 10),
              
              CustomText.smallheadText("Description"),
              SizedBox(height: 10),
              
              CustomText.infoText("A will or testament is a legal document that expresses a person's wishes as to how their property is to be distributed after their death and as to which person is to manage the property until its final distribution. A will is a legal document that coordinates the distribution of your assets after death and can appoint guardians for minor children. A will is important to have, as it allows you to")
             
              ],)),
              customButton.taskButton("Join Call", ()async {


            String dir= widget.isAffidavitPage?"Affidavit":"Agreements";
            String draftfile=await Serverhttphelper.fetchFileUrl(widget.fileName,dir);
            

           await FirebaseFirestore.instance
            .collection('affidavitCall')
            .doc(userClass.uid+widget.fileName)
            .set({
              'userId':userClass.uid,
              'userName':widget.DocumentDetails["Name"],
              'fatherName':widget.DocumentDetails["FatherName"],
              'address': widget.DocumentDetails["Address"],
              'isAffidavit': widget.isAffidavitPage,
              'fileName':draftfile ,
              'callTime':DateTime.now().toString()
            });


            Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: JoinScreen(username:userClass.displayName ,meetingId: widget.fileName+"Affidavit"+userClass.uid,isJoin: false,),
                        type: PageTransitionType.rightToLeft));
              })
             


            ],
          ),
        ),
      // ),
    );
  }
  getNamePriceContainer(){
    return Container(
      
      decoration: BoxDecoration(
        color: Color(0xFFeaeeef),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child:Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.boldDarkText(widget.fileName),
                Row(children: [Icon(Icons.scale,size: 12),SizedBox(width: 5,),CustomText.infoText("88+ users registered")],),
                SizedBox(height: 5),
                CustomText.colorText("Rs. 199/-")
              ],
            ),
          ),
          Container(height: 2,color: Color(0xFF9dabb3)),
          Container(
            padding: EdgeInsets.all(20),
            child: CustomText.infoText("To know more about the service consult a lawyer"))
         

        ],

    ));
  }
}