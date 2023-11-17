import 'package:e_comperce_app/services/filter_product.dart';
import 'package:e_comperce_app/views/product/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeProductListGrid extends ConsumerStatefulWidget {
  const HomeProductListGrid({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeProductListGridState();
}

class _HomeProductListGridState extends ConsumerState<HomeProductListGrid> with SingleTickerProviderStateMixin{
 AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    
        _animationController = AnimationController(
      vsync: this,
      
      duration: Duration(seconds: 2),
    );
    _animationController!.forward();
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.fastOutSlowIn,
    ));
 
  }




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController!.dispose();
  }
  @override
  Widget build(BuildContext context) {
           final featuredProductList =FilterProducts.filterProductWithIsFeatured(ref: ref);
    return AnimatedBuilder(
         animation: _animationController!,
                builder: (context,child) {
                 return Transform(
                              transform: Matrix4.translationValues(
                   
                    0.0,
                     _animation!.value * 50,
                    0.0,
                  ),
              child:  SizedBox(
                height: 400.h,
                child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 0.5.sw,
          mainAxisExtent: 240.h,
                    // childAspectRatio: 2 / 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 20
              ), 
              itemCount: featuredProductList!.length,
              itemBuilder: (context,index){
              return ProductCard(productModel: featuredProductList[index],);
              
              }))
            );  
                }
    );
  }
}