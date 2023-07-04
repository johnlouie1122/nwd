import 'package:flutter/material.dart';
import 'package:nwd/views/New%20Water%20Connection/widgets/questions%20widget/questions_widget.dart';
import 'package:nwd/views/New%20Water%20Connection/widgets/appbar/registration_appbar.dart';
import '../controllers/questions_controller.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegistrationAppbar(
        context: context,
        title: const Text('Orientation Questions'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
        ),
        child: AlertDialog(
          scrollable: true,
          title: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
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
                  [
                    'a. Poland',
                    'b. Denmark',
                    'c. Sweden',
                    'd. All of the above'
                  ],
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
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
      ),
    );
  }
}
