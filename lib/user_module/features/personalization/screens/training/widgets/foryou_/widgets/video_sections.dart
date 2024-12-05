import 'package:flutter/material.dart';
import 'package:t_store/user_module/features/personalization/screens/training/widgets/foryou_/widgets/video_player.dart';
import 'package:video_player/video_player.dart';

class VideoSection extends StatelessWidget {
  final String title;
  final List<String> videoUrls;
  final PageController pageController;
  final Function(int) onPageChanged;
  final List<VideoPlayerController> controllers;
  final double height;

  const VideoSection({
    super.key,
    required this.title,
    required this.videoUrls,
    required this.pageController,
    required this.onPageChanged,
    required this.controllers,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: height,
          child: PageView.builder(
            controller: PageController(
              viewportFraction: 0.7, // Display part of next video
            ),
            padEnds: false, // Aligns videos to the left
            onPageChanged: onPageChanged,
            itemCount: videoUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 4.0), // Reduced padding
                child: Container(
                  height: height,
                  color: Colors.grey[300], // Directly set color, no decoration
                  child: FutureBuilder(
                    future: controllers[index].initialize(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return VideoPlayerWidget(
                          url: videoUrls[index],
                          controller: controllers[index],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
