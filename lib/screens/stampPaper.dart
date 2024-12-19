import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/screens/paymentGateway.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/cutom_message.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:aapka_vakeel/utilities/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call/video_call.dart';

import '../others/locationService.dart';

class StampPaper extends StatefulWidget {
  const StampPaper({super.key});

  @override
  State<StampPaper> createState() => _StampPaperState();
}

class _StampPaperState extends State<StampPaper> {
 final _formKey = GlobalKey<FormState>();
TextEditingController nameController= new TextEditingController();
TextEditingController numberController= new TextEditingController();
TextEditingController addressController= new TextEditingController();
TextEditingController puropseController= new TextEditingController();
TextEditingController amountController= new TextEditingController();
TextEditingController nameController_2= new TextEditingController();
TextEditingController numberController_2= new TextEditingController();
TextEditingController addressController_2= new TextEditingController();
// TextEditingController puropseController_2= new TextEditingController();

  bool singleParty=true;
   // List of items for the dropdown
  final List<String> list = ["Adoption Deed","Option 1", "Option 2", "Option 3"];
  // Selected item
 String dropdownValue ="Adoption Deed";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar.appbar(context,head: 'E-Stamp Paper'),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.fromLTRB(12, 40, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // CustomText.headText("E-Stamp Paper"),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          
            singleParty?customButton.taskButton("Single Party",(){
            }):customButton.cancelButton("Single Party",(){
              setState(() {
              singleParty=true;
              });
            },color: Color(0xFFE0E1DD)),
        
            SizedBox(height: 10),
        
            !singleParty?customButton.taskButton("Double Party",(){
            }):customButton.cancelButton("Double Party",(){
              setState(() {
              singleParty=false;
              });
            },color: Color(0xFFE0E1DD)),
            SizedBox(height: 10),
         DropdownMenu<String>(
          width: MediaQuery.of(context).size.width,
            initialSelection: list.first,
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
                    
            singleParty?getSinglePartyForm(): getDoublePartyForm(),
         
            ],)
        ],),
        ),
      ),
    );
  }

  getSinglePartyForm(){


return Container(
  padding: EdgeInsets.only(top: 30),
  child: Form(
    key: _formKey,
    child: 
    Column(crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

        giveInputField("Name (as on Aadhar card)", nameController, true,TextInputType.name),
        giveInputField("Phone number", numberController, true,TextInputType.phone),
        customButton.cancelButton("Get Location",()async{
         var location= await getLocation();
         if(location['city']!=null){
            addressController.text=location['city']+', ' +location['state']+', '+location['pincode'] ?? '';
            
         }
         
          },color: Color(0xFFE0E1DD)),
        giveInputField("Address", addressController, true,TextInputType.text),
        giveInputField("Purpose", puropseController, true,TextInputType.text),
        giveInputField("Amount", amountController, true,TextInputType.number),
          customButton.taskButton(" Join call", ()async {

            
    var res= await FirebaseFirestore.instance
            .collection('stampPaperCall')
            .doc(userClass.uid+"StampPaper"+dropdownValue)
            .set({
              'userId':userClass.uid,
              'userName':userClass.displayName,
              'isSingleParty':singleParty,
              'stampType': dropdownValue,
              'firstName': nameController.text,
              'firstPhoneNumber': numberController.text,
              'firstAddress':addressController.text,
              'secondName': nameController_2.text,
              'secondPhoneNumber':numberController_2.text ,
              'secondAddress':addressController_2.text,
              'purpose':puropseController.text,
              'amount':amountController.text,
            });
            

         if (_formKey.currentState!.validate()) {
            Navigator.of(context).pushReplacement(
                 MaterialPageRoute(
                  builder: (context) =>JoinScreen(username: userClass.displayName,meetingId: userClass.uid+"stampaper",
                  //isJoin: false,
                  )
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
  )),
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
getLocation() async {
  bool permission = await requestLocationPermission();
  if (permission) {
    context.loaderOverlay.show();
   
    
    try {
      // Check if location services are enabled
      bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        CustomMessenger.defaultMessenger(context, "Location services are disabled. Please enable them.");
        await Geolocator.openLocationSettings();
        return; // Exit the function if location services are disabled
      }
      
      var location = await LocationService.getCityAndState();
      context.loaderOverlay.hide();
   
      return location;
    } catch (e) {
      print("Error: $e");
    } 

  } else {
    CustomMessenger.defaultMessenger(context, "Location permission not granted.");
  }
}
  getDoublePartyForm(){
   

return Container(
  padding: EdgeInsets.only(top: 30),
  child: Form(
    key: _formKey,
    child: 
    Column(crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
        CustomText.RegularDarkText("First party details:"),
        SizedBox(height: 3),
        giveInputField("Name (as on Aadhar card)", nameController, true,TextInputType.name),
        giveInputField("Phone number", numberController, true,TextInputType.phone),
        customButton.cancelButton("Get Location",()async{
         var location= getLocation();
          if(location['city']!=null){
            addressController.text=location['city']+', ' +location['state']+', '+location['pincode'] ?? '';
            addressController_2.text=location['city']+', ' +location['state']+', '+location['pincode'] ?? '';
            
         }
        
         

          }),
        giveInputField("Address", addressController, true,TextInputType.streetAddress),
        giveInputField("Purpose", puropseController, true,TextInputType.text),
        SizedBox(height: 5),
        CustomText.RegularDarkText("Second party details:"),
         giveInputField("Name (as on Aadhar card)", nameController_2, true,TextInputType.name),
        giveInputField("Phone number", numberController_2, true,TextInputType.phone),
        giveInputField("Address", addressController_2, true,TextInputType.streetAddress),
        // giveInputField("Purpose", puropseController_2, true,TextInputType.text),
        giveInputField("Amount", amountController, true,TextInputType.phone),
        SizedBox(height: 3),
          customButton.taskButton(" Join call", () async{

             var res= await FirebaseFirestore.instance
            .collection('stampPaperCall')
            .doc(userClass.uid+"StampPaper"+dropdownValue)
            .set({
              'userId':userClass.uid,
              'userName':userClass.displayName,
              'isSingleParty':singleParty,
              'stampType': dropdownValue,
              'firstName': nameController.text,
              'firstPhoneNumber': numberController.text,
              'firstAddress':addressController.text,
              'secondName': nameController_2.text,
              'secondPhoneNumber':numberController_2.text ,
              'secondAddress':addressController_2.text,
              'purpose':puropseController.text,
              'amount':amountController.text,
            });
            
            
            if (_formKey.currentState!.validate()) {
               Navigator.of(context).pushReplacement(
                 MaterialPageRoute(
                  builder: (context) =>JoinScreen(username: userClass.displayName,meetingId: userClass.uid+"stampaper",
                  //isJoin: false,
                  )
                  // VideoCall(data: snapshot.data!),
                 ));
                       
          }
            else{
            return false;
            }
        
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


          })
    ],
  )),
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
          Container(
             decoration: BoxDecoration(
                color: Colors.white, // Background color for the input
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7), // Shadow color
                    blurRadius: 6, // Spread of the shadow
                    offset: Offset(0, 3), // Position of the shadow
                  ),
                ],
              ),
            child: TextFormField(
                decoration: MyTextField.outlinedTextField(""),
                keyboardType: textInputType,
                controller: controller,
                // readOnly: true,
                 validator: (value) {
                  validationService.validate(value!, textInputType);
                    // if (value == null || value.isEmpty) {
                    //   return 'Please enter ${HeadText}';
                    // }
                    // return null;
                  },
                enabled: true,
                enableInteractiveSelection: false,
                cursorColor: AppColor.primaryTextColor,
                style: TextStyle(
                    color: AppColor.primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    );
  }
}