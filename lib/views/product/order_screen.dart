import 'dart:convert';

import 'package:e_comperce_app/controller/aurh_controller.dart';
import 'package:e_comperce_app/controller/cart_controller.dart';
import 'package:e_comperce_app/controller/order_controller.dart';
import 'package:e_comperce_app/controller/product_controller.dart';
import 'package:e_comperce_app/models/order_model.dart';
import 'package:e_comperce_app/repositary/api_response_helper.dart';
import 'package:e_comperce_app/repositary/order_services/order_service.dart';
import 'package:e_comperce_app/services/filter_product.dart';
import 'package:e_comperce_app/utils/text_field_decoration.dart';
import 'package:e_comperce_app/views/splash/splash_screen.dart';
import 'package:e_comperce_app/views/widgets/bottom_bar_widget.dart';
import 'package:e_comperce_app/views/widgets/custom_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
class OrderScreen extends ConsumerStatefulWidget {
   OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
final _formKey = GlobalKey<FormState>();

TextEditingController cityController =TextEditingController();
TextEditingController phoneController =TextEditingController();

TextEditingController zipCodeController =TextEditingController();
TextEditingController countryController =TextEditingController();
TextEditingController shippingAddress1Controller =TextEditingController();
TextEditingController shippingAddress2Controller =TextEditingController();
Map<String,dynamic>? paymentIntentData;


  createPaymentIntent(String textEditingController, String currency)async{
    try {
      Map<String,dynamic> body ={
        "amount": 222.toString(),
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

 Future<void> makePayment({required OrderModel orderModel})async{
    try {
      paymentIntentData =await ref.watch(orderRepositaryClassProvider).createPaymentIntent( amount: calcuateAmount(ref.watch(totalPriceProvider)!.round().toString()),currency: "USD",context: context);

      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92'),
        // googlePay: const PaymentSheetGooglePay(testEnv: true,  merchantCountryCode: '+92'),
        style: ThemeMode.dark,
        
        merchantDisplayName: 'MOHSIN'
      ));
       displayPayentSheet(orderModel: orderModel);

    } catch (e) {
      print('Exception '+e.toString());
    }
  }


    displayPayentSheet({required OrderModel orderModel})async{
try {
 await Stripe.instance.presentPaymentSheet(
   
    // options: PaymentSheetPresentOptions(
      
    // )
  ).then((value)async {
     print('done');
      // showDialog(context: context, builder: (context)=>AlertDialog(content: Text('paid Successfully'),));

await ref.watch(orderControllerProvider.notifier).placeYourOrder(context, orderModel);



//remove items from list
FilterProducts.removeItemCountWhenOrderPlace(ref: ref,
cartitems: orderModel.orderItems!,
productId: orderModel.orderItems![0].productId);

Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const CustomBottomNavigationBar()));
  });

  setState(() {
    paymentIntentData=null;
  });


} on StripeException catch(e){
  print(e.toString());
  showDialog(context: context, builder: (context)=>AlertDialog(content: Text(e.toString()),));
}
  }

  
  calcuateAmount(String amount){
    final price = int.parse(amount) * 100;

    print(price);
    return price.toString();


  }

var spaceBtn =SizedBox(height: 10.h,);


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cityController.dispose();
    phoneController.dispose();
    zipCodeController.dispose();
    countryController.dispose();
    shippingAddress1Controller.dispose();
    shippingAddress2Controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
               padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                  SizedBox(height: 20.h),
                  Text('PLACE ORDER',style: Theme.of(context).textTheme.headlineMedium,),
                  SizedBox(height: 20.h),
                  
//city
                  TextFormField(
                    controller: cityController,
                      decoration: TextFieldDecoration.decoration(
                    helperText: 'City'
                  ),
                         validator: (value) {
                if (value!.isEmpty) {
                return 'Enter city name';
                }
                return null;
              },
                  ),
                  spaceBtn,
                  TextFormField(
                    controller: countryController,
                      decoration: TextFieldDecoration.decoration(
                    helperText: 'Country'
                  ),
                         validator: (value) {
                if (value!.isEmpty) {
                return 'Enter Country name';
                }
                return null;
              },
                  ),
                  spaceBtn,
                     TextFormField(
                      controller: zipCodeController,
                      decoration: TextFieldDecoration.decoration(
                    helperText: 'Zip Code'
                  ),
                         validator: (value) {
                if (value!.isEmpty) {
                return 'Enter zip code';
                }
                return null;
              },
                  ),
                  spaceBtn,
                         TextFormField(
                      controller: phoneController,
                      decoration: TextFieldDecoration.decoration(
                    helperText: 'Phone'
                  ),
                         validator: (value) {
                if (value!.isEmpty) {
                return 'Enter Phone number';
                }
                return null;
              },
                  ),
                       spaceBtn,

                  //shipping address 1
                TextFormField(
                  controller: shippingAddress1Controller,
                  decoration: TextFieldDecoration.decoration(
                    helperText: 'Shipping Address 1'
                  ),
                    validator: (value) {
                if (value!.isEmpty) {
                return 'Enter Shipping Address ';
                }
                return null;
              },
              maxLines: 4,
                ),
spaceBtn,
                //shipping address 2
                      TextFormField(
                            controller: shippingAddress2Controller,
                        decoration: TextFieldDecoration.decoration(
                          helperText: 'Shipping Address 2',
                          
                        ),
                          validator: (value) {
                if (value!.isEmpty) {
                      return 'Enter Shipping Address ';
                }
                return null;
              },
              maxLines: 4,
                      ),
       SizedBox(height: 20.h,),
       ElevatedButton(onPressed: ()async{
    //  await   makePayment();
       }, child: Text('aa')),

                         Container(
               padding: const EdgeInsets.all(8.0),
               width: 1.sw,
               height: 60.h,
              child: ElevatedButton(onPressed:  ref.watch(orderControllerProvider.notifier).state==false? ()async{
          if (_formKey.currentState!.validate()){

            OrderModel orderModel =OrderModel(
              city: cityController.text.trim(),
              country: countryController.text.trim(),
              orderItems: ref.watch(cartListProvider),
              phone: phoneController.text.trim(),
              shippingAddress1: shippingAddress1Controller.text.trim(),
              shippingAddress2: shippingAddress2Controller.text.trim(),
              zip:zipCodeController.text.trim(),
              user: ref.watch(userProvider)!.sId,
              status: 'panding'
              
            );
            //      OrderModel orderModel =OrderModel(
            //   // city: cityController.text.trim(),
            //   // country: countryController.text.trim(),
            //   orderItems: ref.watch(cartListProvider),
            //   // phone: int.parse(phoneController.text.trim()),
            //   // shippingAddress1: shippingAddress1Controller.text.trim(),
            //   // shippingAddress2: shippingAddress2Controller.text.trim(),
            //   // zip:0000,
            //   user: "6531151c4aa5fd1e33276f3f",
            // );

            // print(ref.watch(cartListProvider));

makePayment(orderModel: orderModel);



// var d=ref.watch(cartListProvider);
// print(d![0].productModel!.sId);




// Navigator.popUntil(context, (route) => false);

          }
              }:null, child:ref.watch(orderControllerProvider.notifier).state==false ? const Text('ORDER'):CircularProgressIndicator())),

                     SizedBox(height: 20.h,),

              ],
            ),
          ),
          
   
        ),
      ),
    );
  }
}