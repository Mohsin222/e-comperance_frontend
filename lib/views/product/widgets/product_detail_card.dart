import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Product_Details_card extends StatelessWidget {
  const Product_Details_card({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(children: [
          Container(
            height: 200.h,
      width: 1.sw,
         decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1613387945987-2d5f05a1ab8b?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGNsb3Roc3xlbnwwfHwwfHx8MA%3D%3D'),fit: BoxFit.cover)),
        
          ),
          Column(
      crossAxisAlignment: CrossAxisAlignment.start,
children: [
  SizedBox(height: 10.h,),
  Text('CATEGORY',
  
    style: TextStyle(
      fontSize: 10.sp,
      color: Colors.black38

    ),
  ),
  SizedBox(height: 5.h,),
  Text('NAME',
    style: TextStyle(
      fontSize: 14.sp,
      color: Colors.black

    ),
  ),
  SizedBox(height: 10.h,),
    Text('This concept for a responsive slideshow was built with Mike Alsup’s Cycle2 plugin for jQuery.',
    style: TextStyle(
      fontSize: 10.sp,
      color: Colors.black38

    ),
    overflow: TextOverflow.ellipsis,
    maxLines: 10,
    ),
    SizedBox(height: 5.h,),
    Divider(
     
    ),
    SizedBox(height: 20.h,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text('\$2222',
  
    style: TextStyle(
      fontSize: 10.sp,
      color: Colors.black38

    ),
  ), 

  ElevatedButton(onPressed: (){}, child: Text('ADD TO CART'))
  
      ],
    )
],
    )
        ]),
      ),
    );
  }
}

