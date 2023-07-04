 import 'package:flutter/material.dart';

import '../../controllers/questions_controller.dart';

Widget buildQuestion(String question, List<String> options, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        const SizedBox(height: 10),
        for (String option in options) ...[
          Text(option),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 10),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Answer',
            contentPadding: EdgeInsets.all(5),
          ),
          maxLength: 1,
          onChanged: (value) {
            userAnswers[index] =
                value; // Update the user's answer in the userAnswers list
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }