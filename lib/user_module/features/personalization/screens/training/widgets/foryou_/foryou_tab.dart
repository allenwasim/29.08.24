import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/user_module/features/authentication/controllers/video_controller.dart/video_controller..dart';
import 'package:t_store/user_module/features/personalization/screens/training/widgets/foryou_/widgets/full_screen_video.dart.dart';
import 'package:t_store/user_module/features/personalization/screens/training/widgets/foryou_/widgets/video_sections.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class DiscoverTab extends StatefulWidget {
  @override
  _DiscoverTabState createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> {
  // Initialize the VideoController
  final VideoController videoController = Get.put(VideoController());

  @override
  void initState() {
    super.initState();
    // Call fetchAllVideos once when the widget is first created
    videoController.fetchAllVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Obx(() {
          // Check loading state
          if (videoController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          // Handle errors
          if (videoController.errorMessage.isNotEmpty) {
            return Center(
              child: Text('Error: ${videoController.errorMessage.value}'),
            );
          }

          // Display videos from the controller
          return ListView(
            children: [
              const SizedBox(height: 16),
              // Search bar
              const TSearchBar(),

              // New Workouts Section
              GestureDetector(
                onTap: () {
                  // Pass initialVideoUrl (the selected video URL) and allVideos dynamically from videoController.videos
                  String initialVideoUrl = videoController.videos[0]
                      ['videoUrl']; // Example: selected video
                  List<String> allVideos = videoController.videos
                      .map((video) => video['videoUrl'] as String)
                      .toList();

                  Get.to(FullScreenVideoReels(
                    initialVideoUrls: [initialVideoUrl], // Selected video URL
                    allVideos: allVideos,
                  ));
                },
                child: VideoSection(
                  title: 'New Workouts',
                  videoUrls: videoController.videos
                      .map((video) => video['thumbnailUrl'] as String)
                      .toList(),
                  height: 290, // Specify the desired height
                ),
              ),
              const SizedBox(height: 16),

              // Great for home Section
              GestureDetector(
                onTap: () {
                  // Pass initialVideoUrl (the selected video URL) and allVideos dynamically from videoController.videos
                  String initialVideoUrl = videoController.videos[1]
                      ['videoUrl']; // Example: selected video
                  List<String> allVideos = videoController.videos
                      .map((video) => video['videoUrl'] as String)
                      .toList();

                  Get.to(FullScreenVideoReels(
                    initialVideoUrls: [initialVideoUrl], // Selected video URL
                    allVideos: allVideos,
                  ));
                },
                child: VideoSection(
                  title: 'Great for home',
                  videoUrls: videoController.videos
                      .map((video) => video['thumbnailUrl'] as String)
                      .toList(),
                  height: 290, // Specify the desired height
                ),
              ),
              const SizedBox(height: 24),

              // Browse Categories Section
              const Text(
                'Browse Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              buildCategoryItem(context, TImages.browseImage1, 'Workout Focus'),
              buildCategoryItem(context, TImages.browseImage2, 'Muscle Group'),
              buildCategoryItem(context, TImages.browseImage3, 'Equipment'),
            ],
          );
        }),
      ),
    );
  }

  Widget buildCategoryItem(
      BuildContext context, String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        // Navigate to the respective category screen (implement navigation)
        Get.toNamed('/category', arguments: title); // Example navigation
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                imagePath), // Use NetworkImage to load images from a URL
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black45,
                  offset: Offset(2, 2),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
