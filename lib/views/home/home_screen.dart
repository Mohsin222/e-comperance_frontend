import 'package:e_comperce_app/controller/aurh_controller.dart';
import 'package:e_comperce_app/controller/product_controller.dart';
import 'package:e_comperce_app/repositary/auth_services/auth_services.dart';
import 'package:e_comperce_app/services/filter_product.dart';
import 'package:e_comperce_app/views/home/widgets/category_button.dart';
import 'package:e_comperce_app/views/product/add_to_card_screen.dart';
import 'package:e_comperce_app/views/product/widgets/product_detail_card.dart';
import 'package:e_comperce_app/views/product/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final user =ref.watch(userProvider);
    final productProvider =ref.watch(prodcutListProvider);

    final featuredProductList =FilterProducts.filterProductWithIsFeatured(productModel: productProvider!.productModel,ref: ref);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [IconButton(onPressed: ()async{
        // await  AuthRepository.products();
       
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CartListScreen()));
        }, icon: const Icon(Icons.shopping_cart,color: Colors.black,))],
        centerTitle: true,
        title: Text('HOME SCREEN',style: TextStyle(color: Colors.black,fontSize: 13.sp),),
      ),
      body:Container(
          margin: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(
          children: [
      SizedBox(height: 10.h,),
          Container(
          
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        height: 0.2.sh,
         
        decoration: BoxDecoration(
         color: Colors.red,
         borderRadius: BorderRadius.circular(10.r),
         image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1561069934-eee225952461?auto=format&fit=crop&q=80&w=1470&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),fit: BoxFit.cover)
        ),
      
          ),
            SizedBox(height: 10.h,),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Categories',
              style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700),
              ),
            ),
     SizedBox(height: 10.h,),
            Row(
              children: List.generate(featuredProductList!.length, (index) => CategoryButton(

                featureProduct: featuredProductList[index],
              )),
            ),
                 SizedBox(height: 10.h,),
      Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.h,
        mainAxisExtent: 240.h,
                  // childAspectRatio: 2 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 20
      ), 
      itemCount: featuredProductList.length,
      itemBuilder: (context,index){
      return ProductCard(productModel: featuredProductList[index],);
      
      }))
      
      
      
        // Image.network(user.)
          ],
        ),
      ) ,
    );
  }
}

