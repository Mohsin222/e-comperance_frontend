import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileTile extends StatelessWidget {
  const CustomProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.r,
        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1619895862022-09114b41f16f?auto=format&fit=crop&q=80&w=1470&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
        
        
      ),
      title: Text('Name',style: TextStyle(fontSize: 14.sp,color: Colors.white),),
      subtitle: Text('mmm@gmail.com',style: TextStyle(fontSize: 14.sp,color: Colors.white),),
      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.white,)),
    );
  }
}

