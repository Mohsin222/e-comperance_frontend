import 'package:e_comperce_app/views/settings/widgets/settings_menutile.dart';
import 'package:e_comperce_app/views/widgets/appbar/custom_appbar.dart';
import 'package:e_comperce_app/views/widgets/appbar/custom_cart_icon.dart';
import 'package:e_comperce_app/views/widgets/custm_primary_header.dart';
import 'package:e_comperce_app/views/widgets/custom_shapes/cusmom_curved_edge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/widgets/home_appbar.dart';
import '../widgets/custom_shapes/circualr_container.dart';
import '../widgets/custom_shapes/curved_widget.dart';
import 'widgets/profiletile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomPrimaryHeaderContainer(child: Column(
              children: [

              //  CustomHomeAppbar(), 
              CustomAppBar(
                showBackArrow: true,
                title: Text('Account'),
              ),
              CustomProfileTile(),
              SizedBox(height: 32,),


    
         
              ],
            ),
            
          
            
            ),
           //body

              Padding(padding: EdgeInsets.all(32),
           child: Column(
            children: [
              
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Account Settings',style: TextStyle(fontSize: 20.sp),),
              Text('view all',style: TextStyle(fontSize: 14.sp),)
            ],
           ),
              SettingMenuTile(icon:Icons.home,title: 'My Address',subtitle: 'Set Shopping dilivery Address',),
            ],
           ),
           ) 
          ],
        ),
      ),
    );
  }
}

