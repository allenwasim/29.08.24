import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/images/circular_image.dart';
import 'package:t_store/common/widgets/text/section_header.dart';
import 'package:t_store/trainer_module/features/controllers/trainer_controller.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/user_module/features/shop/screens/profile/widgets/profile_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TrainerProfileScreen extends StatelessWidget {
  const TrainerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final TrainerDetailsController trainerController = Get.put(
        TrainerDetailsController()); // Use Get.find() instead of Get.put()
    final UserController userController =
        Get.put(UserController()); // Use Get.find() instead of Get.put()
    final AuthenticationRepository authRepo = Get.put(
        AuthenticationRepository()); // Use Get.find() instead of Get.put()

    // Fetch trainer details using the user ID
    trainerController.fetchTrainerDetails(userController.user.value.id);

    return Scaffold(
      backgroundColor: dark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'Trainer Profile',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: dark ? Colors.black : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: dark ? Colors.white : Colors.black),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: dark ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage =
                          userController.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty ? networkImage : TImages.user;
                      return TCircularImage(
                        padding: 4,
                        isNetworkImage: true,
                        image: image,
                        width: 120,
                        height: 120,
                      );
                    }),
                    TextButton(
                      onPressed: () =>
                          userController.uploadUserProfilePicture(),
                      child: const Text("Change Profile Picture"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                title: "Trainer Information",
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() => TProfileMenu(
                    onPressed: () {},
                    title: "Name",
                    value: userController.user.value.fullName,
                  )),
              Obx(() => TProfileMenu(
                    onPressed: () {},
                    title: "Username",
                    value: trainerController.trainer.value?.name ??
                        userController.user.value.fullName,
                  )),
              Obx(() => TProfileMenu(
                    onPressed: () {},
                    title: "Expertise",
                    value: trainerController.trainer.value?.expertise
                            ?.toString() ??
                        "Not Available",
                  )),
              Obx(() => TProfileMenu(
                    onPressed: () {},
                    title: "Certifications",
                    value: trainerController.trainer.value?.certifications
                            ?.toString() ??
                        "Not Available",
                  )),
              Obx(() => TProfileMenu(
                    onPressed: () {},
                    title: "Bio",
                    value: trainerController.trainer.value?.bio?.toString() ??
                        "Not Available",
                  )),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                title: "Contact Information",
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() => TProfileMenu(
                    onPressed: () {},
                    title: "E-mail",
                    value: userController.user.value.email,
                  )),
              Obx(() => TProfileMenu(
                    onPressed: () {},
                    title: "Phone number",
                    value: userController.user.value.phoneNumber ??
                        "Not Available",
                  )),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                title: "Availability",
                showActionButton: false,
              ),
              Obx(() => TProfileMenu(
                    onPressed: () {},
                    title: "Available Days",
                    value: trainerController.trainer.value?.availability ??
                        "Not Available",
                  )),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      child: const Text(
                        "Close Account",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () async {
                        try {
                          await authRepo.deleteAccount();
                        } catch (e) {
                          Get.snackbar("Account Deletion Failed", e.toString(),
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                    ),
                    TextButton(
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        try {
                          await authRepo.logout();
                        } catch (e) {
                          Get.snackbar("Logout Failed", e.toString(),
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
