


  import 'package:flutter/material.dart';

Widget textField(TextEditingController controller, Icon icon, String label, double width) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: width,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: icon,
                labelText: label,
              ),
            ),
          ),
        ],
      ),
    );
  }