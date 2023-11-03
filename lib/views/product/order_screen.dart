import 'package:e_comperce_app/controller/aurh_controller.dart';
import 'package:e_comperce_app/controller/cart_controller.dart';
import 'package:e_comperce_app/controller/order_controller.dart';
import 'package:e_comperce_app/controller/product_controller.dart';
import 'package:e_comperce_app/models/order_model.dart';
import 'package:e_comperce_app/services/filter_product.dart';
import 'package:e_comperce_app/utils/text_field_decoration.dart';
import 'package:e_comperce_app/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
await ref.watch(orderControllerProvider.notifier).placeYourOrder(context, orderModel);

FilterProducts.removeItemCountWhenOrderPlace(ref: ref,
cartitems: orderModel.orderItems!,
productId: orderModel.orderItems![0].productId);


// var d=ref.watch(cartListProvider);
// print(d![0].productModel!.sId);





// Navigator.popUntil(context, (route) => false);
// Navigator.push(context, MaterialPageRoute(builder: (context)=> const SplashScreen()));
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