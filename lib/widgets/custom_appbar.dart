
import 'package:bus_app_screens/model/users.dart';
import 'package:flutter/material.dart';
//import '../assets/colors/color_palette.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? username;
  final String? email;

  CustomAppBar({required this.title, this.username, this.email});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF2A6A92),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          if (username != null && email != null) ...[
            SizedBox.shrink(),
            Text(
              'Logged in as:',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              '$username - $email',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}


class ColorPalette {
  static const primaryColor = Color(0xFF2A6A92);
  static const secondaryColor = Color(0xFF3BA6C9);
  static const accentColor = Color(0xFFE4F4F7);
  static const textColor = Color(0xFF222222);
  static const greyColor = Color(0xFFCCCCCC);
}