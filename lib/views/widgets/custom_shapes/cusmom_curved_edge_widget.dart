import 'package:e_comperce_app/views/widgets/custom_shapes/curved_widget.dart';
import 'package:flutter/material.dart';

class CustomCurveEdgedWidget extends StatelessWidget {
  final Widget? child;
  const CustomCurveEdgedWidget({
    super.key, this.child,
  });


  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdge(),
      child: child
    );
  }
}