import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/screens/paymentGateway.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:video_call/video_call.dart';

class StampPaper extends StatefulWidget {
  const StampPaper({super.key});

  @override
  State<StampPaper> createState() => _StampPaperState();
}

class _StampPaperState extends State<StampPaper> {
  bool singleParty=true;

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
            }),
        
            SizedBox(height: 10),
        
            !singleParty?customButton.taskButton("Double Party",(){
            }):customButton.cancelButton("Double Party",(){
              setState(() {
              singleParty=false;
              });
            }),
          
            singleParty?getSinglePartyForm(): getDoublePartyForm(),
         
            ],)
        ],),
        ),
      ),
    );
  }

  getSinglePartyForm(){
  final _formKey = GlobalKey<FormState>();

TextEditingController nameController= new TextEditingController();
TextEditingController numberController= new TextEditingController();
TextEditingController addressController= new TextEditingController();
TextEditingController puropseController= new TextEditingController();
TextEditingController amountController= new TextEditingController();

return Container(
  padding: EdgeInsets.only(top: 70),
  child: Form(
    key: _formKey,
    child: 
    Column(crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

        giveInputField("Name", nameController, true,TextInputType.name),
        giveInputField("Phone number", numberController, true,TextInputType.phone),
        giveInputField("Address", addressController, true,TextInputType.text),
        giveInputField("Purpose", puropseController, true,TextInputType.text),
        giveInputField("Amount", amountController, true,TextInputType.number),
          customButton.taskButton(" Join call", (){

         if (_formKey.currentState!.validate()) {
            Navigator.of(context).pushReplacement(
                 MaterialPageRoute(
                  builder: (context) =>JoinScreen(username: userClass.displayName,meetingId: userClass.uid+"stampaper",)
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

  getDoublePartyForm(){
      final _formKey = GlobalKey<FormState>();
    TextEditingController nameController= new TextEditingController();
TextEditingController numberController= new TextEditingController();
TextEditingController addressController= new TextEditingController();
TextEditingController puropseController= new TextEditingController();
TextEditingController amountController= new TextEditingController();
    TextEditingController nameController_2= new TextEditingController();
TextEditingController numberController_2= new TextEditingController();
TextEditingController addressController_2= new TextEditingController();
TextEditingController puropseController_2= new TextEditingController();

return Container(
  padding: EdgeInsets.only(top: 70),
  child: Form(
    key: _formKey,
    child: 
    Column(crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
        CustomText.RegularDarkText("First party details:"),
        SizedBox(height: 3),
        giveInputField("Name", nameController, true,TextInputType.name),
        giveInputField("Phone number", numberController, true,TextInputType.phone),
        giveInputField("Address", addressController, true,TextInputType.text),
        giveInputField("Purpose", puropseController, true,TextInputType.text),
        SizedBox(height: 5),
        CustomText.RegularDarkText("Second party details:"),
         giveInputField("Name", nameController_2, true,TextInputType.name),
        giveInputField("Phone number", numberController_2, true,TextInputType.phone),
        giveInputField("Address", addressController_2, true,TextInputType.text),
        giveInputField("Purpose", puropseController_2, true,TextInputType.text),
        giveInputField("Amount", amountController, true,TextInputType.number),
        SizedBox(height: 3),
          customButton.taskButton(" Join call", (){
            if (_formKey.currentState!.validate()) {
               Navigator.of(context).pushReplacement(
                 MaterialPageRoute(
                  builder: (context) =>JoinScreen(username: userClass.displayName,meetingId: userClass.uid+"stampaper",)
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
          TextFormField(
              decoration: MyTextField.outlinedTextField(""),
              keyboardType: textInputType,
              controller: controller,
              // readOnly: true,
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ${HeadText}';
                  }
                  return null;
                },
              enabled: true,
              enableInteractiveSelection: false,
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