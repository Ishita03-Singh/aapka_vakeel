// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class PaymentGateway  {
//    Razorpay razorpay = Razorpay();
//    var context;

   
// PaymentGateway(mContext,options){
//   this.context=mContext;
//   razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
//                   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
//                   razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
//                   razorpay.open(options);
// }


//   void handlePaymentErrorResponse(PaymentFailureResponse response){
//     /*
//     * PaymentFailureResponse contains three values:
//     * 1. Error Code
//     * 2. Error Description
//     * 3. Metadata
//     * */
//     showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
//   }

//   void handlePaymentSuccessResponse(PaymentSuccessResponse response){
//     /*
//     * Payment Success Response contains three values:
//     * 1. Order ID
//     * 2. Payment ID
//     * 3. Signature
//     * */
//     showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
//   }

//   void handleExternalWalletSelected(ExternalWalletResponse response){
//     showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
//   }
//   void showAlertDialog(BuildContext context, String title, String message){
//     // set up the buttons
//     Widget continueButton = ElevatedButton(
//       child: const Text("Continue"),
//       onPressed:  () {},
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(title),
//       content: Text(message),
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }