import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final String leadingImagePath;
  final Function leadingAction;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.blue,
    this.leadingImagePath = 'assets/images/llogo.png',
    required this.leadingAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: Image.asset(
          leadingImagePath,
          width: 24,
          height: 24,
        ),
        onPressed: () => leadingAction(),
      ),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
