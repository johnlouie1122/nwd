import 'package:flutter/material.dart';
import 'package:nwd/views/registration/questions.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text('data'),
      ),
      content: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          const Text('Video')
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Cacnel Process'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const Questions();
                },
              ),
              (Route<dynamic> route) => false,
            );
          },
          child: const Text('Proceed'),
        ),
      ],
    );
  }
}
