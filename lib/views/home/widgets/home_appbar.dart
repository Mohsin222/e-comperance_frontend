import 'package:e_comperce_app/views/widgets/appbar/custom_appbar.dart';
import 'package:e_comperce_app/views/widgets/appbar/custom_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      showBackArrow: false,
      title: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Text('MOHISN IRFAN',style: TextStyle(fontSize: 20.sp),),
   
     ],
    ),
    actions: [
     CustomCartCounterIcon(iconColor: Colors.white,)
    ],
    );
  }
}

