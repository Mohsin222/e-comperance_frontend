import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingMenuTile extends ConsumerWidget {
  final IconData icon;
  final String title,subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  const SettingMenuTile({required this.icon, required this.title, required this.subtitle, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      // contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 25,color: Colors.black,),
        title: Text(title,style: TextStyle(fontSize: 15.sp,color: Colors.black),),
      subtitle: Text(subtitle,style: TextStyle(fontSize: 12.sp,color: Colors.black54),),
      trailing: trailing,
      onTap: onTap,
    );
  }
}