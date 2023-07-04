import 'package:flutter/material.dart';
import 'package:nwd/views/New%20Water%20Connection/views/video.dart';
import 'package:nwd/views/New%20Water%20Connection/views/requirements_main_customer.dart';
import 'package:nwd/views/New%20Water%20Connection/views/requirements_representative.dart';
import 'package:quickalert/quickalert.dart';

final List<String> userAnswers = List.filled(10, '');

final List<String> correctAnswers = [
  'c',
  'd',
  'd',
  'b',
  'a',
  'c',
  'b',
  'c',
  'd',
  'a',
];

int calculateCorrectAnswers() {
  int correctCount = 0;
  for (int i = 0; i < userAnswers.length; i++) {
    if (userAnswers[i].toLowerCase() == correctAnswers[i].toLowerCase()) {
      correctCount++;
    }
  }
  return correctCount;
}

void submitAnswers(BuildContext context) {
  int correctCount = calculateCorrectAnswers();

  if (correctCount < 6) {
    QuickAlert.show(
      barrierDismissible: false,
      context: context,
      onConfirmBtnTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const Video();
            },
          ),
        );
      },
      type: QuickAlertType.error,
      title: 'Failed...',
      text: 'You answered $correctCount out of 10 questions correctly.',
    );
  } else {
    QuickAlert.show(
      barrierDismissible: false,
      context: context,
      title: 'Passed...',
      onConfirmBtnTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Are you a?', style: TextStyle(fontWeight: FontWeight.bold),),
              content: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const RequirementsMainApplicant();
                                },
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.person,
                            size: 80,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const RequirementsRepresentative();
                                },
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.person_add_alt_1,
                            size: 80,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Main Applicant'),
                        SizedBox(
                          width: 30,
                        ),
                        Text('Representative'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      type: QuickAlertType.success,
      text: 'You answered $correctCount out of 10 questions correctly.',
    );
  }
}
