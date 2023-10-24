import 'package:e_comperce_app/controller/cart_controller.dart';
import 'package:e_comperce_app/controller/product_controller.dart';
import 'package:e_comperce_app/models/cart_model.dart';
import 'package:e_comperce_app/models/product_list_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterProducts{
  static List<ProductModel>? filterProductWithIsFeatured({
     required List<ProductModel>? productModel,
    required WidgetRef ref,
  }){
return productModel!.where((element) => element.isFeatured==true).toList();
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
  // for (ProductModel objectA in productProvider!.productModel!) {
  //   for (CartModel objectB in cartProvider!) {
  //     if (objectA.sId == objectB.product) {
  //       mdl.add(objectA);
  //       // ref.read(filterProductTOShowWithCartProvider.notifier).update((state) {
  //       //   state!.add(objectA);

  //       //   return state;
  //       // });

  //       // break; // No need to continue checking this element in listB
  //     }
  //   }
  // }




// return filterProductTOShowWithCart;
return mdl;
  }


  //check its already present in cart

  static checkItsAlreadyPresentInCart({WidgetRef? ref,String? productId}){

    bool response=false;
       final cartProvider =ref!.watch(cartListProvider);

       for (CartModel obj in cartProvider!) {

    if (obj.product == productId){
    response=true;
    break;
      
    }
   
      //  }
      
  }
   return  response;
  }

}