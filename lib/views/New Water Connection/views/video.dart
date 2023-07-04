import 'package:flutter/material.dart';
import 'package:nwd/views/New%20Water%20Connection/views/questions.dart';
import 'package:nwd/views/New%20Water%20Connection/widgets/appbar/registration_appbar.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

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
        _controller.play(); // Auto play the video
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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const Questions()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegistrationAppbar(
        context: context,
        title: const Text('Orientation Video'),
      ),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoPlayer(_controller),
                ),
              ],
            ),
          )),
    );
  }
}
