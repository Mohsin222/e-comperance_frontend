import 'package:flutter/material.dart';

class ProfileMenuTile extends StatelessWidget {
  final VoidCallback? onpress;
  final IconData icon;
  final String title,value;
  const ProfileMenuTile({
    super.key, this.onpress, required this.icon, required this.title, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(title,style: const TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis,)),
                       Expanded(flex: 5, child: Text(value,style: const TextStyle(),overflow: TextOverflow.ellipsis,)),
                                  Expanded(child: Icon(icon,size: 18,)),
          ],
        ),
      ),
    );
  }
}
