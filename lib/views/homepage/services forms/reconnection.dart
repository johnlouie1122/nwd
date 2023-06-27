import 'package:flutter/material.dart';

class ReconnectionForm extends StatefulWidget {
  const ReconnectionForm({super.key});

  @override
  State<ReconnectionForm> createState() => _ReconnectionFormState();
}

class _ReconnectionFormState extends State<ReconnectionForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Water Reconnection Request'),
        ),
        body:  AlertDialog(
          title: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.numbers),
                      labelText: 'Account Number',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.account_circle_outlined),
                      labelText: 'Account Name',
                    ),
                  ),
                ),
                 const SizedBox(height: 10),
                const SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.location_on),
                      labelText: 'Landmark',
                    ),
                  ),
                ),
                 const SizedBox(height: 10),
                  SizedBox(
              width: 300,
              height: 40,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(13, 71, 161, 1),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Sucess!'),
                        content: const Text('Request Submitted Successfully'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
                const Text(
                    'Note: Reconnection of accounts/line requires the payment of the full BALANCE plus reconnection fee of Php 100.00.')
              ],
            ),
          ),
        ));
  }
}
