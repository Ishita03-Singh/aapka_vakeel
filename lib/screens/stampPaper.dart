import 'package:aapka_vakeel/screens/paymentGateway.dart';
import 'package:aapka_vakeel/utilities/colors.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class StampPaper extends StatefulWidget {
  const StampPaper({super.key});

  @override
  State<StampPaper> createState() => _StampPaperState();
}

class _StampPaperState extends State<StampPaper> {
TextEditingController stateController= new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
      padding: EdgeInsets.fromLTRB(12, 40, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        CustomText.headText("E-Stamp Paper"),
        SizedBox(height: 8),
        Form(
       key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      TextFormField(
                decoration: MyTextField.outlinedTextField(""),
                keyboardType: TextInputType.text,
                controller: stateController,
                // readOnly: true,
                 validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter state';
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
      SizedBox(height: 8),
      customButton.taskButton("Pay", (){
        PaymentGateway paymentGateway = new PaymentGateway(context,  {
                    'key': 'rzp_live_ILgsfZCZoFIKMb',
                    'amount': 4045,//the amount is in points like 40.45
                    'name': 'Acme Corp.',
                    'description': 'Fine T-Shirt',
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
                    'external': {
                      'wallets': ['paytm']
                    }
                  }); 
      })
        ],))
      ],),
      ),
    );
  }
}