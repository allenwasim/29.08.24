import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoScreen extends StatefulWidget {
  final VideoPlayerController controller;

  const FullScreenVideoScreen({super.key, required this.controller});

  @override
  _FullScreenVideoScreenState createState() => _FullScreenVideoScreenState();
}

class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.setVolume(1.0); // Unmute sound
    widget.controller.play();
  }

  @override
  void dispose() {
    widget.controller.pause();
    widget.controller
        .setVolume(0.0); // Mute sound when returning to previous screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: VideoPlayer(widget.controller),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
