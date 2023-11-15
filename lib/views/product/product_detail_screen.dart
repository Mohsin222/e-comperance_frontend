import 'package:e_comperce_app/controller/cart_controller.dart';
import 'package:e_comperce_app/models/cart_model.dart';
import 'package:e_comperce_app/models/product_list_model.dart';
import 'package:e_comperce_app/services/filter_product.dart';
import 'package:e_comperce_app/views/widgets/appbar/custom_appbar.dart';
import 'package:e_comperce_app/views/widgets/custom_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custm_primary_header.dart';

class Product_Details_card extends ConsumerWidget {
  final ProductModel productModel;
  const Product_Details_card({
    super.key, required this.productModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Scaffold(
      body: Container(
        // height: 1.sh,
        // width: 1.sw,
        // margin: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(children: [
        
            CustomPrimaryHeaderContainer(
              
              child: Column(
              children: [
        
              //  CustomHomeAppbar(), 
              CustomAppBar(
                showBackArrow: true,
                title: Text('Profile'),
              ),
             
              SizedBox(height: 32,),
        
        
          
         
              ],
            ),
            
          
            
            ),
             
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                     Container(
                margin:const EdgeInsets.all(5),
                height: 200.h,
                  width: 1.sw,
                     decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(productModel.image!),fit: BoxFit.contain)),
                    
              ),
          
              SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                child: Row(
           
               
                  children: List.generate(productModel.images!.length, (index) => Container(
                    height: 100.h,
                    width: 120.w,
                   decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    // image: DecorationImage(image:  NetworkImage(productModel.images![index]),fit: BoxFit.contain)
                    
                   ) ,
                   child: Image(image: NetworkImage(productModel.images![index]),fit: BoxFit.cover),
                  ),
                
                  ),
                ),
              ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h,),
                  
              
                    Text(productModel.name ??'',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black
                  
                      ),
                    ),

                        SizedBox(height: 10.h,),
                  
              
                    Text(productModel.category!.name ??'',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black
                  
                      ),
                    ),
                    SizedBox(height: 10.h,),
                      Text( 'This concept for a responsive slideshow was built with for a responsive slideshow was built w for a responsive slideshow was built wi for a responsive slideshowfor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wifor a responsive slideshow was built wi was built wifor a responsive slideshow was built wifor a responsive slideshow was built wii for a responsive slideshow was built wi for a responsive slideshow was built wi Mike Alsup’s Cycle2 plugin for jQuery.',
                      
                      
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black38
                                    
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                      ),
                      SizedBox(height: 5.h,),
                        Text(productModel.category!.name ?? '',
              
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black38
              
                ),
              ),
          
                    Text('\$${productModel.price}',
                    
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black
              
                ),
                    ),
                      Divider(
                       
                      ),
              
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      const    Text('Rating'),
                          Row(
                            children: [
                              Text(productModel.rating.toString()),
                              Icon(Icons.star,color: Colors.yellow,)
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20.h,),
               
              
                  
                  
                    Container(
                            padding: const EdgeInsets.all(8.0),
                 width: 1.sw,
                 height: 60.h,
                      child: ElevatedButton(onPressed: (){
                           bool ans =   FilterProducts.checkItsAlreadyPresentInCart(ref: ref,productId:productModel!.sId! );
                
                 if(ans ==true){
              
                  CustomSnackBar.buildWarningSnackbar(context,'already in cart');
                
                 }
                 else if(productModel.countInStock! <= 0){
                  print("out of stock");
                 }
                 else{
                CartModel? cartModel = CartModel(productId: productModel!.sId,quantity: 1,productModel: productModel);
                
                
                // print(cartModel.quantity);
                
             ref.watch(cartControllerProvider.notifier).addTocart(context: context,cartModel: cartModel);
                
             ref.watch(totalPriceProvider.notifier).update((state) {
                 state =state! +      productModel!.price!.toDouble();
                 return state;
             });
                 }
                      }, child: Text('ADD TO CART')))
                    
                       
                  ],
                      ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

