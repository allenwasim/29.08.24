import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
      final User = await userRepository.fetchUserDetails();
      this.user(User);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      await fetchUserRecord();

      if (user.value.id.isEmpty) {}

      if (userCredentials != null) {
        final nameParts =
            UserModel.splitFullName(userCredentials.user!.displayName ?? "");
        final username =
            UserModel.createUsername(userCredentials.user!.displayName ?? "");

        final newUser = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0], // Fixed index to 0 for firstName
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "",
          email: userCredentials.user!.email ?? " ",
          username: username,
          profilePicture: userCredentials.user!.photoURL ?? "",
        );

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
      imageUploading.value == true;
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
        TLoaders.warningSnackBar(
            title: "Update Failed",
            message:
                "There was an issue updating your profile picture. Please try again.");
      } finally {
        imageUploading.value == false;
      }
    }
  }
}
