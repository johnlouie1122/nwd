import 'package:flutter/material.dart';




class ServiceForm extends StatefulWidget {
  const ServiceForm({super.key});

  @override
  State<ServiceForm> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services Form'),
      ),
      body: AlertDialog(
        scrollable: true,
        title: const Text(
          'Service Form',
          textAlign: TextAlign.center,
        ),
        content: Column(
          children: [
            const SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.landscape),
                  labelText: 'PUROK/DISTRICT/STREET',
                ),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.landscape),
                  labelText: 'PUROK/DISTRICT/STREET',
                ),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'BARANGAY',
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
