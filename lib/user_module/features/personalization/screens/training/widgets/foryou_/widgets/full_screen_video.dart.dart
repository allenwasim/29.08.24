import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoReels extends StatefulWidget {
  final List<String> initialVideoUrls; // Initial videos to display
  final List<String>
      allVideos; // Additional videos to display after the initial ones

  const FullScreenVideoReels({
    Key? key,
    required this.initialVideoUrls,
    required this.allVideos,
  }) : super(key: key);

  @override
  _FullScreenVideoReelsState createState() => _FullScreenVideoReelsState();
}

class _FullScreenVideoReelsState extends State<FullScreenVideoReels> {
  late PageController _pageController;
  late List<VideoPlayerController> _controllers;
  late List<String> _videoUrls;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Initialize the video URLs (initial videos + all videos)
    _videoUrls = [...widget.initialVideoUrls, ...widget.allVideos];

    // Initialize the video controllers with video URLs
    _controllers = _videoUrls
        .map((url) => VideoPlayerController.network(url)..initialize())
        .toList();

    // Start playing the first video after initialization
    _controllers[0].play();
  }

  @override
  void dispose() {
    // Dispose of the video controllers when done
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Fetch random videos when user scrolls to a new page
  void fetchRandomVideosAndUpdate(int index) {
    // Check if the user has reached the end of the current list
    if (index == _videoUrls.length - 1) {
      // Add more random videos from the allVideos list
      List<String> newVideos =
          List.from(widget.allVideos); // Fetching more random videos
      _videoUrls.addAll(newVideos);

      // Add new controllers for the newly added videos
      _controllers.addAll(
        newVideos
            .map((url) => VideoPlayerController.network(url)..initialize()),
      );

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen Vertical Video Player with Infinite Scrolling
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical, // Vertical scrolling
            itemCount: null, // Infinite scrolling
            onPageChanged: (index) {
              // Stop video playback of the previous video
              for (var i = 0; i < _controllers.length; i++) {
                if (i != index && _controllers[i].value.isPlaying) {
                  _controllers[i].pause();
                }
              }
              // Play the current video
              _controllers[index].play();

              // Fetch random videos when scrolling reaches the last video
              fetchRandomVideosAndUpdate(index);
            },
            itemBuilder: (context, index) {
              final controller = _controllers[
                  index % _videoUrls.length]; // Infinite scrolling logic
              return GestureDetector(
                onTap: () {
                  // Toggle play/pause when tapped
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                },
                child: Stack(
                  children: [
                    VideoPlayer(controller), // The video itself
                    Center(
                      child: controller.value.isInitialized &&
                              !controller.value.isPlaying
                          ? Icon(
                              Icons.play_circle_fill,
                              size: 60,
                              color: Colors.white,
                            )
                          : Container(),
                    ),
                  ],
                ),
              );
            },
          ),
          // Optionally, add a Close button for Full Screen
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}
