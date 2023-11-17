import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_comperce_app/controller/aurh_controller.dart';
import 'package:e_comperce_app/controller/product_controller.dart';
import 'package:e_comperce_app/repositary/auth_services/auth_services.dart';
import 'package:e_comperce_app/repositary/load_data.dart';
import 'package:e_comperce_app/services/filter_product.dart';
import 'package:e_comperce_app/utils/text_field_decoration.dart';
import 'package:e_comperce_app/views/home/widgets/caresol_slider.dart';
import 'package:e_comperce_app/views/home/widgets/category_button.dart';
import 'package:e_comperce_app/views/home/widgets/home_appbar.dart';
import 'package:e_comperce_app/views/home/widgets/home_product_list_grid.dart';
import 'package:e_comperce_app/views/product/add_to_card_screen.dart';
import 'package:e_comperce_app/views/product/product_detail_screen.dart';
import 'package:e_comperce_app/views/product/widgets/product_widget.dart';
import 'package:e_comperce_app/views/widgets/bottom_bar_widget.dart';
import 'package:e_comperce_app/views/widgets/custm_primary_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/order_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
   HomeScreen({super.key});

  @override
 ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController searchController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  


  giveinitialValToField(){
          searchController.text =ref.watch(seachValue);
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context ) {
    final user =ref.watch(userProvider);
    final productProvider =ref.watch(prodcutListProvider.notifier);
    final categoryListProv =ref.watch(categoryListProvider);
    
   
       final featuredProductList =FilterProducts.filterProductWithIsFeatured(ref: ref);
  
giveinitialValToField();
    // final featuredProductList =FilterProducts.filterProductWithIsFeatured(productModel: productProvider.productModel,ref: ref);
    return  Scaffold(
      // appBar: AppBar(

      //   backgroundColor: Colors.white,
      //   actions: [
      //     IconButton(onPressed: ()async{
  
      //       // print(user!.sId);
      //       print('111');
      //       //  await   LoadData.getUserData(context: context, ref: ref);
      //     }, icon:Icon(Icons.add,color: Color.fromARGB(255, 8, 8, 8))),
      //     IconButton(onPressed: ()async{
      //   // await  AuthRepository.products();
       
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CartListScreen()));
      //   }, icon: const Icon(Icons.shopping_cart,color: Colors.black,))],
      //   centerTitle: true,
      //   title: Text(user!.email.toString(),style: TextStyle(color: Colors.black,fontSize: 13.sp),),
      // ),
      body:Container(
        height: 1.sh,
          // margin: EdgeInsets.symmetric(horizontal: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomPrimaryHeaderContainer(
                height: 280.h,
                child:  Column(children: [
                   CustomHomeAppbar(
                  
                   ),
        

                SizedBox(height: 12.h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: TextField(
                    controller: searchController,
                    decoration: TextFieldDecoration.homeTextFieldDecoration(hintText: 'search'),
                    
                    onChanged: (v){
                      // print(v);

                      ref.read(seachValue.notifier).state=v;

              
                    },
                  )
                ),

                 SizedBox(height: 25.h,),
                
              Container(
                 padding: EdgeInsets.symmetric(horizontal: 10.w),
                alignment: Alignment.centerLeft,
                child: Text('Categories',
                style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700,color: Colors.white),
                ),
              ),
             SizedBox(height: 10.h,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(categoryListProv.length, (index) => CategoryButton(
              onpress: (){
                 ref.watch(categoryValue.notifier).state=categoryListProv[index]!.name!;
               
              },
                    category: categoryListProv[index],
                  )),
                ),
              ),
                ],)
              ),
            
              SizedBox(height: 10.h,),
       
   CustomCarsolSlider(),
                 SizedBox(height: 10.h,),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                alignment: Alignment.centerLeft,
                child: Text('Featured',
                style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700),
                ),
              ),
              Text('View all',style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w300,color: Colors.pinkAccent),)
          ],
         ),          
                   SizedBox(height: 10.h,),
          //     SizedBox(
          //       height: 400.h,
          //       child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // maxCrossAxisExtent: 0.5.sw,
          // mainAxisExtent: 240.h,
          //           // childAspectRatio: 2 / 3,
          //           crossAxisSpacing: 5,
          //           mainAxisSpacing: 20
          //     ), 
          //     itemCount: featuredProductList!.length,
          //     itemBuilder: (context,index){
          //     return ProductCard(productModel: featuredProductList[index],);
              
          //     }))
              HomeProductListGrid(),
              
              
          // Image.network(user.)
            ],
          ),
        ),
      ) ,

      
    );
  }
}

