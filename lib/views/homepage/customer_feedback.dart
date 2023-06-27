// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class CustomerFeedback extends StatefulWidget {
  const CustomerFeedback({Key? key}) : super(key: key);

  @override
  CustomerFeedbackbackState createState() => CustomerFeedbackbackState();
}

class CustomerFeedbackbackState extends State<CustomerFeedback> {
  int _selectedOption = 0; // Track the selected radio option

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Content here : '),
              Radio<int>(
                value: 1,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value ?? 0;
                  });
                },
              ),
              const Text('Option 1'),
              Radio<int>(
                value: 2,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value ?? 0;
                  });
                },
              ),
              const Text('Option 2'),
              Radio<int>(
                value: 3,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value ?? 0;
                  });
                },
              ),
              const Text('Option 3'),
              Radio<int>(
                value: 4,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value ?? 0;
                  });
                },
              ),
              const Text('Option 4'),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Process the selected option
            print('Selected option: $_selectedOption');
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
