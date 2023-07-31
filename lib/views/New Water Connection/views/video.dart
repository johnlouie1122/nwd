import 'package:flutter/material.dart';
import 'package:nwd/views/New%20Water%20Connection/views/questions.dart';
import 'package:nwd/views/services%20forms/main.view.dart';
import 'package:quickalert/quickalert.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final String code;
  const Video({Key? key, required this.code}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/video/sample.mp4',
    )..initialize().then((_) {
        setState(() => checkVideoCompletion());
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkVideoCompletion() {
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        questionsMainApplicant(widget.code);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(_controller),
            ),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  QuickAlert.show(
                    context: context,
                    confirmBtnText: 'Yes',
                    showCancelBtn: true,
                    cancelBtnText: 'No',
                    type: QuickAlertType.error,
                    title: 'Confirmation . . .',
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
          ],
        ),
      ),
    );
  }

  void questionsMainApplicant(String code) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return Questions(code: code);
        });
  }
}
