
import 'package:flutter/material.dart';
import 'package:nwd/views/user/homepage/homepage.dart';

class CustomerFeedback extends StatefulWidget {
  const CustomerFeedback({super.key});

  @override
  CustomerFeedbackbackState createState() => CustomerFeedbackbackState();
}

class CustomerFeedbackbackState extends State<CustomerFeedback> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer:  const CustomDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: AlertDialog(
          scrollable: true,
          title: Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                const Text('Customer Feedback tab'),
              ],
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Customer Feedback')
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
