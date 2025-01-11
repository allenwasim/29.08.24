import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:t_store/user_module/features/authentication/controllers/video_controller.dart/video_controller..dart';
import 'package:t_store/user_module/features/personalization/screens/training/widgets/foryou_/widgets/full_screen_video.dart.dart';

class VideoSection extends StatelessWidget {
  final String title;
  final List<String> videoUrls; // List of video URLs to show thumbnails
  final double height;

  VideoSection({
    super.key,
    required this.title,
    required this.videoUrls,
    required this.height,
  });
  final VideoController videoController = Get.put(VideoController());

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
        // Creating a simple list of video thumbnails
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videoUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    right: 8.0), // Space between thumbnails
                child: Container(
                  width: 120, // Width for each thumbnail
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    child: Image.network(
                      videoUrls[
                          index], // Show the video thumbnail using Image.network
                      fit: BoxFit.cover,
                    ),
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
