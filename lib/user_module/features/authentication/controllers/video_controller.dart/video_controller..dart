import 'dart:math'; // For random number generation
import 'package:get/get.dart';
import 'package:t_store/trainer_module/data/repositories/video_repository.dart';

class VideoController extends GetxController {
  final VideoRepository videoRepository = Get.put(VideoRepository());

  // Observable list of videos
  var videos = <Map<String, dynamic>>[].obs;

  // Loading and error states
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Fetch videos by trainer ID
  Future<void> fetchVideosByTrainer(String trainerId) async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Clear previous errors
      List<Map<String, dynamic>> fetchedVideos =
          await videoRepository.fetchVideosByTrainer(trainerId);
      videos.value = fetchedVideos; // Update the video list
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch all videos (for browsing section)
  Future<void> fetchAllVideos() async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Clear previous errors
      List<Map<String, dynamic>> fetchedVideos =
          await videoRepository.fetchAllVideos();
      videos.value = fetchedVideos; // Update the video list
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Upload video tutorial
  Future<void> uploadVideoTutorial(
      String trainerId, Map<String, dynamic> videoDetails) async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Clear previous errors
      await videoRepository.uploadVideoTutorial(
          trainerId: trainerId, videoDetails: videoDetails);
      // Optionally, refresh the video list after successful upload
      fetchVideosByTrainer(
          trainerId); // Or use fetchAllVideos() depending on the use case
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch random videos for scrolling (e.g., for Reels)
  Future<void> fetchRandomVideos(int count) async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Clear previous errors

      // Fetch all videos
      List<Map<String, dynamic>> allVideos =
          await videoRepository.fetchAllVideos();

      // Shuffle the list of videos to get random order
      allVideos.shuffle(Random());

      // Take the first 'count' number of videos from the shuffled list
      List<Map<String, dynamic>> randomVideos = allVideos.take(count).toList();

      // Update the video list with random videos
      videos.value = randomVideos;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
