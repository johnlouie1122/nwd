import 'package:flutter/material.dart';



class Disconnection extends StatefulWidget {
  const Disconnection({super.key});

  @override
  State<Disconnection> createState() => _DisconnectionState();
}

class _DisconnectionState extends State<Disconnection> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voluntary Disconnection Request'),
      ),
      body: AlertDialog(
        scrollable: true,
        content: Column(
          children: [
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
                  labelText: 'Previous Reading',
                ),
              ),
            ),
             const SizedBox(height: 10),
            const SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Current Reading',
                ),
              ),
            ),
             const SizedBox(height: 10),
            const SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Consumption',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
          ],
        ),
      ),
    );
  }
}
