import 'package:e_comperce_app/views/widgets/custom_shapes/circualr_container.dart';
import 'package:e_comperce_app/views/widgets/custom_shapes/cusmom_curved_edge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPrimaryHeaderContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  const CustomPrimaryHeaderContainer({
    super.key, required this.child, this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCurveEdgedWidget(
      child: Container(
        padding: EdgeInsets.zero,
        // width: 1.sw,
        decoration: BoxDecoration(
    
        // color: Colors.blue[400],
        color: Colors.pink[400],
        ),
        child: SizedBox(
          height: height ?? null,
          child: Stack(
    children: [
         
            Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(backgroundColor: Colors.white.withOpacity(0.1),)),
                                    Positioned(
                                           top: 100,
              right: -300,
                                      child: TCircularContainer(
                                        backgroundColor: Colors.white.withOpacity(0.1),),
                                    ),
                                    child
        
    ],
          ),
        ),
      ),
    );
  }
}



