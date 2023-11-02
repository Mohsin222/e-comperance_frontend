import 'package:e_comperce_app/controller/order_controller.dart';
import 'package:e_comperce_app/controller/product_controller.dart';
import 'package:e_comperce_app/models/product_list_model.dart';
import 'package:e_comperce_app/repositary/order_services/order_service.dart';
import 'package:e_comperce_app/views/product/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/cart_controller.dart';
import '../../services/filter_product.dart';

class CartListScreen extends ConsumerStatefulWidget {
  const CartListScreen({super.key});

  @override
  ConsumerState<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends ConsumerState<CartListScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider =ref.watch(cartListProvider);
//  final productProvider =ref.watch(prodcutListProvider);

//  final filter =FilterProducts.fiterForAddToCard(ref: ref,);
    return  Scaffold(
appBar: AppBar(
  title: Text('CART'),
),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
        itemCount: cartProvider?.length ?? 0,
        itemBuilder: (context,index){

     



        return Card(
          child: Container(
            width: 100.w,
            // height: 200.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            child: Row(
              children: [
             Container(
                height: 70.h,
                width: 0.3.sw,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(image: NetworkImage(cartProvider![index].productModel!.image??'https://images.unsplash.com/photo-1609709295948-17d77cb2a69b?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y2xvdGhzfGVufDB8fDB8fHww'),fit: BoxFit.cover)),

              ),
                SizedBox(width: 5.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              
                  // Text(cartProvider![index].product.toString()),
                  
                     Text(cartProvider[index].productModel!.name ?? ''),
                     Text(cartProvider[index].productModel!.price.toString() ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 
                  children: [
                          Text(cartProvider[index].quantity.toString() ),
                Row(
                  children: [
                    

                       CartButton(icon: Icons.remove,onpress: (){
                                           if(cartProvider[index].quantity! >0){
          
                    ref.read(cartControllerProvider.notifier).decrementCartQuantity(context: context, index: index, value: 1,cartModel: cartProvider[index]);
                                      
                                      
                                      
                                           }

                     setState(() {
                   
                 });   
                       },),
                    
                       SizedBox(width: 5.h,),
                    Text(cartProvider[index].quantity.toString()),
                    SizedBox(width: 5.h,),
             

                       CartButton(icon: Icons.add,onpress: (){

                        if(cartProvider[index].productModel!.countInStock! <= cartProvider[index].quantity!.toInt()){
print('Not in stock');
                        }else{
                                      ref.watch(cartControllerProvider.notifier).incrementCartQuantity(context: context, index: index, value: 1 ,cartModel: cartProvider[index]);
                        }
                          

                     setState(() {
                   
                 });   
                       },),
                  ],
                )
                  ],
                )              ],
                            ),
                ),
            
              ],
            ),
          ),
          
        );
      }),),
      SizedBox(height: 10.h,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('TOTAL',style: TextStyle(fontWeight: FontWeight.w600),),
                      Text(ref.watch(totalPriceProvider).toString(),style: TextStyle(fontWeight: FontWeight.w400),)
          ],
        ),
      ),
            SizedBox(height: 10.h,),
            Container(
               padding: const EdgeInsets.all(8.0),
               width: 1.sw,
               height: 60.h,
              child: ElevatedButton(onPressed:cartProvider!.length > 0 ? ()async{
final orderProv =await ref.read(orderControllerProvider);
// print(cartProvider![0].product);
// ignore: use_build_context_synchronously
// await ref.read(orderControllerProvider.notifier).placeYourOrder(context,cartProvider);

Navigator.push(context, MaterialPageRoute(builder: (context){
  return OrderScreen();
}));

              }:null, child: Text('ORDER')))
        ],
      )
    );
  }
}


class CartButton extends StatelessWidget {
  final VoidCallback? onpress;
  final IconData icon;
  const CartButton({super.key, this.onpress, required this.icon});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onpress,
      child: Container(
                                           decoration:  BoxDecoration(
                                                   borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(),
                          // color: Colors.blue,
                          shape: BoxShape.rectangle),
                          child: Icon((icon)),
                                         ),
    );
  }
}