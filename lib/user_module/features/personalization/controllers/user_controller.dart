import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/trainer_module/features/sections/add_trainer_details/add_trainer_details_screen.dart';
import 'package:t_store/user_module/data/repositories/user/user_repositries.dart';
import 'package:t_store/user_module/features/personalization/models/user_model.dart';
import 'package:t_store/utils/popups/loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  final imageUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final fetchedUser = await userRepository.fetchUserDetails();
      user.value = fetchedUser; // Corrected this line
      profileLoading.value = false;
    } catch (e) {
      user.value = UserModel.empty(); // Corrected this line
    }
  }

  Future<void> saveUserRecord(
      UserCredential? userCredentials, bool isTrainer) async {
    try {
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        // Handle the case if the user has an empty id
      }

      if (userCredentials != null) {
        final nameParts = userCredentials.user!.displayName?.split(" ") ?? [];
        final username = nameParts.isNotEmpty
            ? nameParts[0].toLowerCase() +
                (nameParts.length > 1
                    ? nameParts[1].substring(0, 1).toLowerCase()
                    : '')
            : '';

        final newUser = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts.isNotEmpty
                ? nameParts[0]
                : "", // Fixed index to 0 for firstName
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "",
            email: userCredentials.user!.email ?? " ",
            username: username,
            profilePicture: userCredentials.user!.photoURL ?? "",
            role: isTrainer ? "trainer" : "client");

        await userRepository.saveUserRecord(newUser);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: "Data not saved",
          message:
              "Something went wrong with your information. You can re-save your data in your profile");
    }
  }

  Future<void> uploadUserProfilePicture() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (image != null) {
      imageUploading.value = true; // Corrected this line
      try {
        // Await the uploadImage to get the image URL
        final imageUrl =
            await userRepository.uploadImage("Users/Images/Profile/", image);

        // Update the user's profile picture in Firestore
        Map<String, dynamic> json = {"profilePicture": imageUrl};
        await userRepository.updateSingleField(json);

        // Update the local user model with the new profile picture URL
        user.update((u) {
          if (u != null) {
            u.profilePicture = imageUrl;
          }
        });

        // Show success message
        TLoaders.successSnackBar(
            title: "Congratulations",
            message: "Your profile picture has been updated");
      } catch (e) {
        print("Image upload error: $e");

        TLoaders.warningSnackBar(
            title: "Update Failed",
            message:
                "There was an issue updating your profile picture. Please try again.");
      } finally {
        imageUploading.value = false; // Corrected this line
      }
    }
  }
}
