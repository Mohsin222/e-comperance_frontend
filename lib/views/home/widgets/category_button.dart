import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/product_list_model.dart';

class CategoryButton extends StatelessWidget {
  final ProductModel? featureProduct;
  
  const CategoryButton({super.key, this.featureProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 207, 25, 89),
                borderRadius: BorderRadius.circular(6.r)
              ),
                
                
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(featureProduct!.category!.name.toString(),
                style: const TextStyle(color: Colors.white,letterSpacing: 2),
                ),
                
                );
  }
}