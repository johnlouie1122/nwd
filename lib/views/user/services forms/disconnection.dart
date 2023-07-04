// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../homepage/homepage.dart';

class Disconnection extends StatefulWidget {

  const Disconnection({Key? key}) : super(key: key);

  @override
  State<Disconnection> createState() => _DisconnectionState();
}

class _DisconnectionState extends State<Disconnection> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController previousReadingController =
      TextEditingController();
  final TextEditingController currentReadingController =
      TextEditingController();
  final TextEditingController consumptionController = TextEditingController();

  Future<void> submitForm() async {
    final response = await http.post(
      Uri.parse('http://localhost/nwd/disconnection.php'),
      body: {
        'accountNumber': accountNumberController.text,
        'previousReading': previousReadingController.text,
        'currentReading': currentReadingController.text,
        'consumption': consumptionController.text,
      },
    );

    if (response.statusCode == 200 && response.body == 'success') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success!'),
            content: const Text('Request Submitted Successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Home();
                      },
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    accountNumberController.dispose();
    previousReadingController.dispose();
    currentReadingController.dispose();
    consumptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: AlertDialog(
          scrollable: true,
          content: Column(
            children: [
              SizedBox(
                height: 10,
                width: MediaQuery.of(context).size.width / 2,
              ),
              const Text(
                'Voluntary Disconnection Form',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: accountNumberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.numbers),
                    labelText: 'Account Number',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: previousReadingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Previous Reading',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: currentReadingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Current Reading',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: consumptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Consumption',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 500,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: submitForm,
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
      ),
    );
  }
}
