import 'package:flutter/material.dart';

class RegistrationAppbar extends AppBar {
  RegistrationAppbar({
    Key? key,
    required BuildContext context,
    Widget? title,
    List<Widget>? actions,
  }) : super(
          key: key,
          title: title ?? const Text('Registration Process'),
          leading: IconButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Warning!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: const Text(
                        'Are you sure you want to cancel the process?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                          
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          actions: actions ??
              <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    'NWD ADMIN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ],
        );
}
