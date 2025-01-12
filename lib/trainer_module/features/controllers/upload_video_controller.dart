import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:t_store/trainer_module/data/repositories/video_repository.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class UploadVideoController extends GetxController {
  // Form controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final VideoRepository videoRepository = Get.put(VideoRepository());

  // Video and Thumbnail paths
  var selectedFilePath = Rx<String?>(null); // Using Rx for reactive state
  var thumbnailPath = Rx<String?>(null); // Using Rx for reactive state

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Upload progress and state variables
  var uploadProgress = 0.0.obs; // Observable to track upload progress
  var isUploading =
      false.obs; // Observable to track if the upload is in progress

  // Function to handle file picking for video
  Future<void> pickVideoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      selectedFilePath.value =
          result.files.single.path; // Update reactive variable
    }
  }

  // Function to handle file picking for thumbnail
  Future<void> pickThumbnailFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      thumbnailPath.value =
          result.files.single.path; // Update reactive variable
    }
  }

  // Function to upload file to Firebase Storage and get download URL
  Future<String?> uploadFileToFirebase(
      String filePath, String storagePath) async {
    try {
      final file = File(filePath);
      final storageRef = FirebaseStorage.instance.ref().child(storagePath);

      // Upload file in chunks to avoid memory overload
      final uploadTask = storageRef.putFile(file);

      // Listen to upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        uploadProgress.value = progress;
      });

      // Wait for upload to complete and get the download URL
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading file: $e"); // Log any errors
      throw Exception("Failed to upload file: $e");
    }
  }

  void submitForm(BuildContext context, String trainerId) async {
    if (_formKey.currentState!.validate() && selectedFilePath.value != null) {
      try {
        // Show the loading dialog
        TFullScreenLoader.openLoadingDialog(
            'Uploading Video...', TImages.emailVerification);

        isUploading.value = true; // Set uploading flag to true
        // Paths for video and thumbnail storage
        String videoStoragePath =
            'videos/${DateTime.now().millisecondsSinceEpoch}.mp4';
        String thumbnailStoragePath =
            'thumbnails/${DateTime.now().millisecondsSinceEpoch}.jpg';

        // Upload video
        String? videoUrl = await uploadFileToFirebase(
            selectedFilePath.value!, videoStoragePath);

        String? thumbnailUrl;
        if (thumbnailPath.value != null) {
          // Upload thumbnail separately if it exists
          thumbnailUrl = await uploadFileToFirebase(
              thumbnailPath.value!, thumbnailStoragePath);
        }

        if (videoUrl != null) {
          final videoDetails = {
            "title": titleController.text,
            "description": descriptionController.text,
            "tags":
                tagsController.text.split(",").map((e) => e.trim()).toList(),
            "videoUrl": videoUrl,
            "thumbnailUrl": thumbnailUrl,
          };

          // Call the VideoRepository to upload the video details with URLs to Firestore
          await videoRepository.uploadVideoTutorial(
            trainerId: trainerId,
            videoDetails: videoDetails,
          );

          // Hide the loading dialog and show success message
          AuthenticationRepository.instance
              .screenRedirect(); // Close the loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Video uploaded successfully!")),
          );

          // Clear the form and reset UI state
          _formKey.currentState!.reset();
          selectedFilePath.value = null;
          thumbnailPath.value = null;
          uploadProgress.value = 0.0; // Reset upload progress
        } else {
          throw Exception("Video upload failed.");
        }
      } catch (e) {
        // Hide the loading dialog and show error message
        Navigator.pop(context); // Close the loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      } finally {
        isUploading.value = false; // Set uploading flag to false after upload
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please fill in all fields and select a video.")),
      );
    }
  }

  // Getter for form key
  GlobalKey<FormState> get formKey => _formKey;
}
