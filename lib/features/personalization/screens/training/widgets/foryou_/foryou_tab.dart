import 'package:flutter/material.dart';
import 'package:t_store/features/personalization/screens/training/widgets/foryou_/widgets/video_sections.dart';
import 'package:video_player/video_player.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class DiscoverTab extends StatefulWidget {
  const DiscoverTab({super.key});

  @override
  _DiscoverTabState createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> {
  final PageController _pageControllerNewWorkouts = PageController();
  final PageController _pageControllerGreatForHome = PageController();
  int _currentPageNewWorkouts = 0;
  int _currentPageGreatForHome = 0;

  late List<VideoPlayerController> _controllersNewWorkouts;
  late List<VideoPlayerController> _controllersGreatForHome;

  @override
  void initState() {
    super.initState();

    // Initialize controllers for "New Workouts"
    _controllersNewWorkouts = [
      for (var url in [
        "assets/videos/1.mp4",
        'assets/videos/2.mp4',
      ])
        VideoPlayerController.asset(url)
          ..initialize()
          ..setLooping(true)
          ..setVolume(0.0) // Mute sound
          ..addListener(() {
            if (mounted) setState(() {});
          })
    ];

    // Initialize controllers for "Great for Home"
    _controllersGreatForHome = [
      for (var url in [
        'assets/videos/3.mp4',
        'assets/videos/4.mp4',
      ])
        VideoPlayerController.asset(url)
          ..initialize()
          ..setLooping(true)
          ..setVolume(0.0) // Mute sound
          ..addListener(() {
            if (mounted) setState(() {});
          })
    ];
  }

  @override
  void dispose() {
    for (var controller in _controllersNewWorkouts) {
      controller.dispose();
    }
    for (var controller in _controllersGreatForHome) {
      controller.dispose();
    }
    _pageControllerNewWorkouts.dispose();
    _pageControllerGreatForHome.dispose();
    super.dispose();
  }

  void _onPageChangedNewWorkouts(int index) {
    setState(() {
      _currentPageNewWorkouts = index;
    });
    _updateVideoPlaybackNewWorkouts();
  }

  void _onPageChangedGreatForHome(int index) {
    setState(() {
      _currentPageGreatForHome = index;
    });
    _updateVideoPlaybackGreatForHome();
  }

  void _updateVideoPlaybackNewWorkouts() {
    for (int i = 0; i < _controllersNewWorkouts.length; i++) {
      if (i == _currentPageNewWorkouts) {
        _controllersNewWorkouts[i].play();
      } else {
        _controllersNewWorkouts[i].pause();
      }
    }
  }

  void _updateVideoPlaybackGreatForHome() {
    for (int i = 0; i < _controllersGreatForHome.length; i++) {
      if (i == _currentPageGreatForHome) {
        _controllersGreatForHome[i].play();
      } else {
        _controllersGreatForHome[i].pause();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            // Search bar
            const TSearchBar(),

            // New Workouts Section
            VideoSection(
              title: 'New Workouts',
              videoUrls: const [
                "assets/videos/1.mp4",
                'assets/videos/2.mp4',
              ],
              pageController: _pageControllerNewWorkouts,
              onPageChanged: _onPageChangedNewWorkouts,
              controllers: _controllersNewWorkouts,
              height: 290, // Specify the desired height
            ),
            const SizedBox(
              height: 16,
            ),
            VideoSection(
              title: 'Great for home',
              videoUrls: const [
                "assets/videos/1.mp4",
                'assets/videos/2.mp4',
              ],
              pageController: _pageControllerNewWorkouts,
              onPageChanged: _onPageChangedNewWorkouts,
              controllers: _controllersNewWorkouts,
              height: 290,
              // Specify the desired height
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
        ),
      ),
    );
  }

  Widget buildCategoryItem(
      BuildContext context, String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        // Navigate to the respective category screen
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
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
