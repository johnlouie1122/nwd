import 'package:flutter/material.dart';

Widget fileButton(
      String? fileName, String buttonText, VoidCallback onPressed, double width) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          ListTile(
            title: Text(
              fileName == null ? buttonText : '$buttonText ($fileName)',
              style: TextStyle(
                color: fileName != null ? Colors.black : Colors.grey,
              ),
            ),
            trailing: IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.folder),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
