


import 'package:e_comperce_app/models/cart_model.dart';
import 'package:e_comperce_app/models/order_model.dart';
import 'package:e_comperce_app/repositary/local_storage_services/local_storage_repositary.dart';
import 'package:e_comperce_app/repositary/order_services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final userOrderListProvider = StateProvider<List<OrderModel?>>((ref) => [
]);

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
    // state = true;
   await _orderRepositaryClass.placeOrder(context:context,orderModel: orderModel);


    // print(user);
        state = false;


  
  }



          Future<void> getUserOrders(BuildContext context, String? userId ) async {
    // state = true;
 List<OrderModel?> orderlist = 
 await _orderRepositaryClass.userOrders(context:context,userId: userId);


print(orderlist.toString() +'aaaaaaaaaaaaaaaaaaa');



    // print(user);
        state = false;
    _ref.read(userOrderListProvider.notifier).update((state){
state = orderlist;


      return state;

    });

  
  }
}