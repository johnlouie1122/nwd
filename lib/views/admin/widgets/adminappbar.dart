import 'package:flutter/material.dart';



class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
    required BuildContext context, // Add BuildContext as a required parameter
    Widget? title,
    List<Widget>? actions,
  }) : super(
          key: key,
          title: title ?? const Text('Admin Panel'),
          actions: actions ?? 
              <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text('NWD ADMIN', style: TextStyle(fontWeight: FontWeight.bold),)),
                ),
              ],
        );
}
