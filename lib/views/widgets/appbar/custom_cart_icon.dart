import 'package:flutter/material.dart';

class CustomCartCounterIcon extends StatelessWidget {
  final Color iconColor;
  final VoidCallback? onpress;
  const CustomCartCounterIcon({
    super.key, required this.iconColor, this.onpress,
  });

  @override
  Widget build(BuildContext context) {
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
         child: Center(child: Text('2',style: TextStyle(color: Colors.white,
         
         ),
         ),),
        ))
      ],
    );
  }
}

