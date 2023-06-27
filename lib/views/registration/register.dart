// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nwd/views/registration/video.dart';
import '../login/login.dart';

class RegisterFirst extends StatefulWidget {
  const RegisterFirst({super.key});

  @override
  RegisterFirstState createState() => RegisterFirstState();
}

class RegisterFirstState extends State<RegisterFirst> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();

  Future<void> _submitForm() async {
    // Retrieve the form field values
    String name = _nameController.text;
    String address = _addressController.text;
    String contactNumber = _contactNumberController.text;

    // Check if any of the fields are blank
    if (name.isEmpty || address.isEmpty || contactNumber.isEmpty) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
            content: const Text('Please fill in all the required fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Create the request body
    Map<String, String> requestBody = {
      'name': name,
      'address': address,
      'contactNumber': contactNumber,
    };

    try {
      // Send the form data to the PHP endpoint
      var response = await http.post(
        Uri.parse('http://localhost/nwd/register.php'),
        body: requestBody,
      );

      if (response.body == 'success') {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Reminder', style: TextStyle(fontWeight: FontWeight.bold)),
              content: const Center(child: Text('Successfully registered!')),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const Video();
                      }),
                    );
                  },
                  child: const Text('Proceed'),
                ),
              ],
            );
          },
        );
      } else if (response.body == 'exists') {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
              content: const Center(child: Text('The contact number is already used. Please try a different one.')),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
              content: const Center(child: Text('Registration failed. Please try again.')),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
      // Handle any error that occurred during the request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Process'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const LoginPage();
                },
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: AlertDialog(
        scrollable: true,
        title: const Column(
          children: [
            Text(
              'STEP 1: ',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'ENTER BASIC DETAILS',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Center(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.person),
                  labelText: 'COMPLETE NAME',
                ),
              ),
              const SizedBox(
                height: 10,
                width: 300,
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.location_pin),
                  labelText: 'ADDRESS',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _contactNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.phone),
                  labelText: 'CONTACT NUMBER',
                ),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: _submitForm,
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
