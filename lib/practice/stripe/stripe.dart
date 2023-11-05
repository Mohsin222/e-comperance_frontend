import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
class StripeScreen extends StatefulWidget {
   StripeScreen({super.key});

  @override
  State<StripeScreen> createState() => _StripeScreenState();
}

class _StripeScreenState extends State<StripeScreen> {

  TextEditingController textEditingController =TextEditingController();
Map<String,dynamic>? paymentIntentData;

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('APP BAR'),),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          TextField(
            controller: textEditingController,
            keyboardType: TextInputType.number,
            
          ),
          //     CardField(
          //   onCardChanged: (card) {
          //     print(card);
          //   },
          // ),
InkWell(
  onTap: ()async{
await makePayment();
  },
  child:   Container(
  
    height: 50,
  
    width: 200,
  
    decoration: BoxDecoration(
  
      color: Colors.green
  
    ),
  
    child: Center(child: Text('Pay'),),
  
  ),
)
      ]),
    );
  }

  Future<void> makePayment()async{
    try {
      paymentIntentData =await  createPaymentIntent(textEditingController.text.trim(),"USD");

      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92'),
        // googlePay: const PaymentSheetGooglePay(testEnv: true,  merchantCountryCode: '+92'),
        style: ThemeMode.dark,
        
        merchantDisplayName: 'MOHSIN'
      ));
       displayPayentSheet();

    } catch (e) {
      print('Exception '+e.toString());
    }
  }

  displayPayentSheet()async{
try {
 await Stripe.instance.presentPaymentSheet(
   
    // options: PaymentSheetPresentOptions(
      
    // )
  ).then((value) {
     print('done');
      showDialog(context: context, builder: (context)=>AlertDialog(content: Text('paid Successfully'),));
  });

  setState(() {
    paymentIntentData=null;
  });


} on StripeException catch(e){
  print(e.toString());
  showDialog(context: context, builder: (context)=>AlertDialog(content: Text(e.toString()),));
}
  }

  createPaymentIntent(String textEditingController, String currency)async{
    try {
      Map<String,dynamic> body ={
        "amount": catcuateAmont(22.toString()),
        "currency":currency,
        "payment_method_types[]":"card"
      };

      var response =await  http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
      
    
      headers: {
        "Authorization":'Bearer sk_test_51IMtIYCIzz5B7On2eHMccJ3W6UkNzbguxQ8WH73V8RXbaFmzvihKVjja1hyz25BbZ3mBTo9ZDegAHWuH5vQpvBhn00pLyl74Hl',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (e) {
       print('Exception  createPaymentIntent errro '+e.toString());
    }
  }

  catcuateAmont(String amount){
    final price = int.parse(amount) * 100;
    return price.toString();
  }
}