import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPress;
  const CustomAppBar({super.key, this.title,  this.showBackArrow=false, this.leadingIcon, this.actions, this.leadingOnPress});

  @override
  Widget build(BuildContext context,) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        automaticallyImplyLeading: showBackArrow,
        // backgroundColor: Colors.pink[400],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: showBackArrow ? IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back)) :
        leadingIcon != null ? IconButton(onPressed:leadingOnPress, icon: Icon(leadingIcon)) :null,
   
        actions: actions,
             title: title,

      )
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}