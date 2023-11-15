import 'dart:math';

import 'package:e_comperce_app/controller/product_controller.dart';
import 'package:e_comperce_app/models/cart_model.dart';
import 'package:e_comperce_app/models/product_list_model.dart';
import 'package:e_comperce_app/repositary/local_storage_services/local_storage_repositary.dart';
import 'package:e_comperce_app/repositary/product_services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final filterProductTOShowWithCartProvider = StateProvider<List<ProductModel>?>((ref) => []);


final totalPriceProvider = StateProvider<double?>((ref) => 0);
final cartListProvider = StateProvider<List<CartModel>?>((ref) => []);




final cartControllerProvider =
    StateNotifierProvider<CartController, bool>((ref) {
  return CartController(

    localStorageRepository: LocalStorageRepository(),
    ref: ref,
  );
});

class CartController extends StateNotifier<bool> {

  final LocalStorageRepository _localStorageRepository;
  final Ref _ref;

    CartController(
      {
      required LocalStorageRepository localStorageRepository,
      required Ref ref})
      : 
        _localStorageRepository = localStorageRepository,
        _ref = ref,
        super(false);



        addTocart({required BuildContext context, CartModel? cartModel}){


    _ref.read(cartListProvider.notifier).update((state){
state!.add(cartModel!);


return state;

    });



}
incrementCartQuantity({required BuildContext context,required int index, required int value,CartModel? cartModel }){


//     _ref.watch(cartListProvider.notifier).update((state){

// state![index].quantity =state[index].quantity! + value;
// return state;

//     });
_ref.read(cartListProvider.notifier).update((state){
// print(state![index].quantity.toString() +"BEFORE");
state![index].quantity =state[index].quantity!  + value;
// print(state[index].quantity.toString() +"AFTER");


return state;

    });

  _ref.watch(totalPriceProvider.notifier).update((state) {
   state =state! +      cartModel!.productModel!.price!.toDouble();
   return state;
       });
    // _ref.read(totalPriceProvider.notifier).update((state) {
    //   state = productModel.price! * value;

    //   return state;
    // });
}


decrementCartQuantity({required BuildContext context,required int index, required int value,CartModel? cartModel }){


_ref.read(cartListProvider.notifier).update((state){

state![index].quantity =state[index].quantity!  - value;


// var minus =cartModel.productModel.price 

       _ref.watch(totalPriceProvider.notifier).update((state) {
   state =state! -      cartModel!.productModel!.price!.toDouble();
   return state;
       });

if(state[index].quantity == 0.0){
  state.removeAt(index);
// _ref.read(filterProductTOShowWithCartProvider)!.removeWhere((element) => element.sId == productModel.sId);
  // state.removeWhere((element) => element.product==productModel.sId);
}
return state;



    });


}

totalPrice(){
_ref.watch(cartListProvider);
_ref.watch(prodcutListProvider);
}
}