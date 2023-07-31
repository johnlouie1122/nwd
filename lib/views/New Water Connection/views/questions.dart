// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:nwd/views/New%20Water%20Connection/views/certificate.dart';
import 'package:nwd/views/New%20Water%20Connection/views/video.dart';
import 'package:nwd/views/services%20forms/main.view.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

class Questions extends StatefulWidget {
  final String code;
  const Questions({super.key, required this.code});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  QuickAlert.show(
                    context: context,confirmBtnText: 'Yes',
                    showCancelBtn: true,
                    cancelBtnText: 'No',
                    type: QuickAlertType.error,
                    title: 'Confirmation. . .',
                    text: 'Are you sure you want to cancel?',
                    onCancelBtnTap: () {
                      Navigator.pop(context);
                    },
                    onConfirmBtnTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const MainView(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.cancel_rounded,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1,
          ),
          const Text(
            'STEP 3: ',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'Enter the Correct answer in the textfield provided',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Center(
        child: Column(
          children: [
            buildQuestion(
              '1. How many Infinity Stones are there?',
              ['a. 3', 'b. 5', 'c. 6', 'd. 10'],
              0,
            ),
            buildQuestion(
              '2. What is the only food that cannot go bad?',
              [
                'a. Dark chocolate',
                'b. Peanut butter',
                'c. Canned tuna',
                'd. Honey'
              ],
              1,
            ),
            buildQuestion(
              '3. Which was René Magritte’s first surrealist painting?',
              [
                'a. Not to Be Reproduced',
                'b. Personal Values',
                'c. The Lovers',
                'd. The Lost Jockey'
              ],
              2,
            ),
            buildQuestion(
              '4. What 90s boy band member bought Myspace in 2011?',
              [
                'a. Nick Lachey',
                'b. Justin Timberlake',
                'c. Shawn Stockman',
                'd. AJ McLean'
              ],
              3,
            ),
            buildQuestion(
              '5. What is the most visited tourist attraction in the world?',
              [
                'a. Eiffel Tower',
                'b. Statue of Liberty',
                'c. Great Wall of China',
                'd. Colosseum'
              ],
              4,
            ),
            buildQuestion(
              '6. What’s the name of Hagrid’s pet spider?',
              ['a. Nigini', 'b. Crookshanks', 'c. Crookshanks', 'd. Mosag'],
              5,
            ),
            buildQuestion(
              '7. What’s the heaviest organ in the human body?',
              ['a. Brain', 'b. Liver', 'c. Skin', 'd. Heart'],
              6,
            ),
            buildQuestion(
              '8. Who made the third most 3-pointers in the Playoffs in NBA history?',
              [
                'a. Kevin Durant',
                'b. JJ Reddick',
                'c. Lebron James',
                'd. Kyle Korver'
              ],
              7,
            ),
            buildQuestion(
              '9. Which of these EU countries does not use the euro as its currency?',
              ['a. Poland', 'b. Denmark', 'c. Sweden', 'd. All of the above'],
              8,
            ),
            buildQuestion(
              '10. Which US city is the sunniest major city and sees more than 320 sunny days each year?',
              [
                'a. Phoenix – Phoenix sees more than 320 sunny days each year.',
                'b. Miami',
                'c. San Francisco',
                'd. Austin'
              ],
              9,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  submitAnswers(context, widget.code);
                },
                child: const Text(
                  'Submit Answers',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

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

  void submitAnswers(BuildContext context, String code) async {
    int correctCount = calculateCorrectAnswers();
    String status = correctCount < 6 ? 'FAILED' : 'PASSED';

    var response = await http.post(
      Uri.parse('https://capstone.smccnasipit.edu.ph/ocsms-nwd/user-services/orientation_status.php'),
      body: {'code': code, 'status': status},
    );

    if (response.statusCode == 200) {
      if (status == 'FAILED') {
        QuickAlert.show(
          barrierDismissible: false,
          context: context,
          onConfirmBtnTap: () {
            backToVideo(code);
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
            certificate(code);
          },
          type: QuickAlertType.success,
          text: 'You answered $correctCount out of 10 questions correctly.',
        );
      }
    } else {
      print('Failed to submit status to the server.');
    }
  }

  void backToVideo(String code) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return Video(code: code);
        });
  }

  void certificate(String code) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return Certificate(code: code);
        });
  }

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
                value; 
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
