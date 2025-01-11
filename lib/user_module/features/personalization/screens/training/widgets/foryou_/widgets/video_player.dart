import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/user_module/features/personalization/screens/training/widgets/foryou_/widgets/full_screen_video.dart.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final String url;
  final VideoPlayerController controller;
  final List<String> videoUrls; // List of video URLs

  const VideoPlayerWidget({
    super.key,
    required this.url,
    required this.controller,
    required this.videoUrls, // Accept the list of video URLs
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: 16 / 9, // Adjust the aspect ratio if needed
              child: VideoPlayer(controller),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
