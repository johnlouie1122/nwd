import 'package:flutter/material.dart';
import 'package:nwd/views/registration/requirements.dart';
import 'package:nwd/views/registration/video.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
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
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Quiz Result'),
            content: Text(
              'Failed! You answered $correctCount out of 10 questions correctly.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Video();
                      },
                    ),
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
            title: const Text('Quiz Result'),
            content: Text(
              'Passed! You answered $correctCount out of 10 questions correctly.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Requirements();
                      },
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
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
                value; // Update the user's answer in the userAnswers list
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.jpg'),
          fit: BoxFit.cover
        ),
      ),
      child: AlertDialog(
        scrollable: true,
        title: const Column(
          children: [
            Text(
              'STEP 3: ',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
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
                width: 300,
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(13, 71, 161, 1),
                  ),
                  onPressed: () {
                    submitAnswers(context);
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
      ),
    );
  }
}
