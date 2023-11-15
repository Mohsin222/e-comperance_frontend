import 'package:e_comperce_app/services/filter_product.dart';
import 'package:e_comperce_app/utils/text_field_decoration.dart';
import 'package:e_comperce_app/views/home/widgets/category_button.dart';
import 'package:e_comperce_app/views/home/widgets/home_appbar.dart';
import 'package:e_comperce_app/views/widgets/custm_primary_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/product_controller.dart';
import 'widgets/product_widget.dart';

class ProductScreen extends ConsumerStatefulWidget {
   ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}



class _ProductScreenState extends ConsumerState<ProductScreen> {
  TextEditingController searchController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context, ) {
    final productProvider =ref.watch(prodcutListProvider)!.productModel;

    // final filterList = FilterProducts.searchProduct(productModel: productProvider,ref: ref,);
    final filterList =FilterProducts.filterProductWithCategoryAndSearch(ref: ref);
    final categoryListProv =ref.watch(categoryListProvider);
    // searchController.text =ref.watch(seachValue);
  
  print(filterList!.length);
    return Scaffold(

      body: Container(child: Column(children: [
  CustomPrimaryHeaderContainer(
        height: 300.h,
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
                 print(ref.watch(categoryValue));
              },
                    category: categoryListProv[index],
                  )),
                ),
              ),
                
        
        
                ],)
              ),
                      SizedBox(height: 25.h,),
                           Expanded(
      
                child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 0.5.sw,
          mainAxisExtent: 240.h,
                    // childAspectRatio: 2 / 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 20
              ), 
              itemCount: filterList.length,
              itemBuilder: (context,index){
              return ProductCard(productModel: filterList![index],);
              
              }))

      ],)),
    );
  }
}