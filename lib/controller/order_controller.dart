


import 'package:e_comperce_app/controller/cart_controller.dart';
import 'package:e_comperce_app/models/cart_model.dart';
import 'package:e_comperce_app/models/order_model.dart';
import 'package:e_comperce_app/repositary/local_storage_services/local_storage_repositary.dart';
import 'package:e_comperce_app/repositary/order_services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final userOrderListProvider = StateProvider<List<OrderModel?>>((ref) => [
]);


final orderNextPagePaginationValue = StateProvider<bool>((ref) => true);
final initalDataLoaded = StateProvider<bool>((ref) => false);
final orderControllerProvider =
    StateNotifierProvider<OrderController, bool>((ref) {
  return OrderController(
    orderRepositaryClass: ref.read(orderRepositaryClassProvider),
    localStorageRepository: LocalStorageRepository(),
    ref: ref,
  );
});


class OrderController extends StateNotifier<bool>{
    final OrderRepositaryClass _orderRepositaryClass;
  final LocalStorageRepository _localStorageRepository;
  final Ref _ref;
    OrderController(
      {required OrderRepositaryClass orderRepositaryClass,
      required LocalStorageRepository localStorageRepository,
      required Ref ref})
      : _orderRepositaryClass = orderRepositaryClass,
        _localStorageRepository = localStorageRepository,
        _ref = ref,
        super(false);






        Future<void> placeYourOrder(BuildContext context, OrderModel? orderModel) async {
    state = true;
   await _orderRepositaryClass.placeOrder(context:context,orderModel: orderModel);


    // print(user);
        state = false;


  _ref.watch(cartListProvider.notifier).state=[];
_ref.watch(totalPriceProvider.notifier).state=0;
  }



  



          Future<void> getUserOrders({required BuildContext context, String? userId ,required int pageNo} ) async {
    state = true;





 List<OrderModel?> orderlist = 
 await _orderRepositaryClass.userOrders(context:context,userId: userId, pageNo: pageNo);


                    if (_ref.watch(orderNextPagePaginationValue) == true){




    // print(user);
      
    _ref.read(userOrderListProvider.notifier).update((state){
state = orderlist;


      return state;

    });
                    }
                      state = false;

                      _ref.watch(initalDataLoaded.notifier).state=true;


   //in this function first call on userOrder initState it load the inital data
   //
   //in this i call another proder 'initialDataLoaded to avoid again and agin call whem we open user orders screen because it call on initstate  
   //if you want to call again i use  pull refresher on first i change the 'initalLaodedDta to false'                   
  
  }


            Future<void> loadMoreOrders({required BuildContext context, String? userId ,required int pageNo} ) async {

 List<OrderModel?> orderlist = 
 await _orderRepositaryClass.userOrders(context:context,userId: userId, pageNo: pageNo);


// print(orderlist.toString() +'aaaaaaaaaaaaaaaaaaa');

 if(orderlist.isEmpty ){
 _ref.read(orderNextPagePaginationValue.notifier).state=false;

}else{

    _ref.read(userOrderListProvider.notifier).update((state){
state.addAll(orderlist);


      return state;

    });
}

    // print(user);
    
//in this function first call on userOrder scrollController it load the more with page increment 
//it always calls i create a prover to check more  'orderNextPagePaginationValue' if it is true it run again and again
//it become false when the list length is  []
  
  }
}