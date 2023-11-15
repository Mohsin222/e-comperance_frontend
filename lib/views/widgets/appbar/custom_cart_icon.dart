import 'package:e_comperce_app/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCartCounterIcon extends ConsumerWidget {
  final Color iconColor;
  final VoidCallback? onpress;
  const CustomCartCounterIcon({
    super.key, required this.iconColor, this.onpress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final cartListCount =ref.read(cartListProvider.notifier);
    return Consumer(builder: (context,_ref,_){
      return Stack(
      children: [
        IconButton(onPressed:onpress, icon: Icon(Icons.shopping_bag,color: iconColor,)),
        Positioned(
          right: 0,
          child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
             color: Colors.black,
             borderRadius: BorderRadius.circular(100)
          ),
         child: Center(child: Text(_ref.watch(cartListProvider.select((value) => value!.length.toString())),style: TextStyle(color: Colors.white,
         
         ),
         ),),
        ))
      ],
    );
    });
  }
}

