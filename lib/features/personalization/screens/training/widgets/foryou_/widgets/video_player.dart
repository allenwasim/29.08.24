import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:t_store/features/personalization/screens/training/widgets/foryou_/widgets/full_screen_video.dart.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final String url;
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    super.key,
    required this.url,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FullScreenVideoScreen(controller: controller));
      },
      child: controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: 16 / 9, // Adjust the aspect ratio if needed
              child: VideoPlayer(controller),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
