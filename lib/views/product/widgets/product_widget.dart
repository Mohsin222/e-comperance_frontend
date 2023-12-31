// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_comperce_app/models/cart_model.dart';
import 'package:e_comperce_app/services/filter_product.dart';
import 'package:e_comperce_app/views/product/product_detail_screen.dart';
import 'package:e_comperce_app/views/widgets/custom_snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_comperce_app/controller/product_controller.dart';
import 'package:e_comperce_app/models/product_list_model.dart';

import '../../../controller/cart_controller.dart';

class ProductCard extends ConsumerWidget {
  final ProductModel? productModel;
  const ProductCard({super.key, 
    this.productModel,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final productPriv = ref.watch(prodcutListProvider);

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
         return  Product_Details_card(productModel: productModel!,);
        },));
      },
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
        child: Card(
          clipBehavior: Clip.hardEdge,
          shadowColor: Colors.pinkAccent,
          child: Column(
            children: [
              Container(height: 130.h,
              width: 1.sw,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
           decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(image: NetworkImage(productModel!.image ?? 'https://images.unsplash.com/photo-1613387945987-2d5f05a1ab8b?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGNsb3Roc3xlbnwwfHwwfHx8MA%3D%3D'),fit: BoxFit.cover)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(productModel!.countInStock.toString()),
              IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.heart_fill,color: Colors.red,),)
            ],
          ),
              ),
              Container(
             padding: EdgeInsets.symmetric(horizontal: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    
      SizedBox(height: 10.h,),
      Text( productModel!.category!.name ??'CATEGORY',
      
      style: TextStyle(
        fontSize: 10.sp,
        color: Colors.black38
    
      ),
      ),
      SizedBox(height: 3.h,),
      Text(productModel!.name ?? 'Name',
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.black
    
      ),
      ),
      SizedBox(height: 4.h,),
      Text(productModel!.description ??'This concept for a responsive slideshow was built with Mike Alsup’s Cycle2 plugin for jQuery.',
      style: TextStyle(
        fontSize: 10.sp,
        color: Colors.black38
    
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      ),
      // SizedBox(height: 5.h,),
      // Divider(
      //   height: 0,
      // ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text("\$ ${ productModel!.price}",
      
      style: TextStyle(
        fontSize: 10.sp,
        color: Colors.black38
    
      ),
      ), 
    
      Container(
    
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
        InkWell(onTap: (){
      
       bool ans =   FilterProducts.checkItsAlreadyPresentInCart(ref: ref,productId:productModel!.sId! );
      
       if(ans ==true){
    
        CustomSnackBar.buildWarningSnackbar(context,'already in cart');
      
       }
       else if(productModel!.countInStock! <= 0){
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
      
        }, child: Icon(Icons.shopping_cart,size: 20.sp,     color: Colors.black38)),
    
       InkWell(
        onTap: (){},
        child: Icon(Icons.heat_pump_rounded,size: 20.sp,     color: Colors.black38),
       )
      ],),
      )
        ],
      )
    ],
      ))
            ],
        ),
        ),
      ),
    );
  }
}
