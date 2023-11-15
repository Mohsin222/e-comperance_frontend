import 'package:e_comperce_app/controller/cart_controller.dart';
import 'package:e_comperce_app/controller/product_controller.dart';
import 'package:e_comperce_app/models/cart_model.dart';
import 'package:e_comperce_app/models/product_list_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterProducts{
  static List<ProductModel>? filterProductWithIsFeatured({
    //  required List<ProductModel>? productModel,
    required WidgetRef ref,
  }){
   final categValue= ref.watch(categoryValue);
     final searchVal=ref.watch(seachValue);
         var productProvider =ref.watch(prodcutListProvider)!.productModel;
      if(categValue !='All'){

productProvider=showProductWithCategory(productModel: productProvider,ref: ref);
      }
      if(searchVal !=''){
  return productProvider!.where((element) => element.name!.contains(searchVal)).toList();
}

      

return productProvider!.where((element) => element.isFeatured==true).toList();
  }

    static List<ProductModel>? showProductWithCategory({
     required List<ProductModel>? productModel,
    required WidgetRef ref,
  }){
   final categValue= ref.watch(categoryValue);

   
// ignore: unrelated_type_equality_checks
return productModel!.where((element) => element.category!.name==categValue).toList();

  }


//search product
    static List<ProductModel>? searchProduct({
     required List<ProductModel>? productModel,
    required WidgetRef ref,
    
  }){


   final searchVal=ref.watch(seachValue);
// ignore: unrelated_type_equality_checks
// return productModel!.contains((element) => element.category!.name==categValue).toList();//
if(searchVal !=''){
  return productModel!.where((element) => element.name!.contains(searchVal)).toList();
}else{
  return productModel;
}



  }





//filter that product that id present in cart list
    static List<ProductModel>? fiterForAddToCard({
    //  required List<ProductModel>? productModel,
    required WidgetRef ref,
    // required List<CartModel>? cart_model,
  }){
    List<ProductModel>? mdl=[];

final filterProductTOShowWithCart=ref.watch(filterProductTOShowWithCartProvider);
   final cartProvider =ref.watch(cartListProvider);
 final productProvider =ref.watch(prodcutListProvider);




return mdl;
  }



  //filterProduct with CategoryAndSeacrch
  static List<ProductModel>? filterProductWithCategoryAndSearch({
    //  required List<ProductModel>? productModel,
    required WidgetRef ref,
  }){
   final categValue= ref.watch(categoryValue);
     final searchVal=ref.watch(seachValue);
         var productProvider =ref.watch(prodcutListProvider)!.productModel;
      if(categValue !='All'){

productProvider=showProductWithCategory(productModel: productProvider,ref: ref);
      }
      if(searchVal !=''){
  return productProvider!.where((element) => element.name!.contains(searchVal)).toList();
}

      

return productProvider!;
  }

  //check its already present in cart

  static checkItsAlreadyPresentInCart({WidgetRef? ref,String? productId}){

    bool response=false;
       final cartProvider =ref!.watch(cartListProvider);

       for (CartModel obj in cartProvider!) {

    if (obj.productId == productId){
    response=true;
    break;
      
    }
   
      //  }
      
  }
   return  response;
  }


  //remove item count when order place
    static  removeItemCountWhenOrderPlace({
     required String? productId,
     required List<CartModel?> cartitems,
    required WidgetRef ref,
    // required List<CartModel>? cart_model,
  }){
final proDlist=ref.watch(prodcutListProvider);
    // var d =ref.watch(prodcutListProvider)!.productModel!.where((element) => element.sId==productId).toList(); 
    // print(d);

    for(int i=0;i<proDlist!.productModel!.length; i++){
   for(int j=0;j<cartitems.length;j++){
    // print(j);
       if(proDlist.productModel![i].sId == cartitems[j]!.productId){

  
        ref.watch(prodcutListProvider.notifier).update((state) {


        
 state!.productModel![i].countInStock=proDlist.productModel![i].countInStock!.toInt() - cartitems[j]!.quantity!.toInt();


             print(state.productModel![i].countInStock.toString()   + 'index');
       return state;
        });
       }
   }
    }
     }

}