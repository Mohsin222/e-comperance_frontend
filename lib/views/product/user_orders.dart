import 'package:e_comperce_app/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserOrders extends ConsumerWidget {
  const UserOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userOrdProv =ref.watch(userOrderListProvider);
    return Scaffold(

      body: ListView.builder(
        itemCount: userOrdProv.length,
        itemBuilder: (context,index){
        return Text(userOrdProv[index]!.totalPrice.toString());
      }),
    );
  }
}