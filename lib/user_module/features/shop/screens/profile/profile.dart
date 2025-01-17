import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/images/circular_image.dart';
import 'package:t_store/common/widgets/text/section_header.dart';
import 'package:t_store/user_module/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/user_module/features/authentication/controllers/client_details/client_details_controller.dart';
import 'package:t_store/user_module/features/personalization/screens/memberships/tabs/active/membership_training_screen.dart';
import 'package:t_store/user_module/features/shop/screens/profile/widgets/change_name.dart';
import 'package:t_store/user_module/features/shop/screens/profile/widgets/profile_menu.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final UserController controller = Get.put(UserController());
    final ClientDetailsController detailsController =
        Get.put(ClientDetailsController());
    final AuthenticationRepository authRepo =
        Get.put(AuthenticationRepository());

    // Ensure that the client details are fetched
    detailsController.fetchClientDetails(controller.user.value.id);

    return Scaffold(
      backgroundColor: dark ? Colors.black : Colors.white,
      appBar: AppBar(
        title:
            Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
        backgroundColor: dark ? Colors.black : Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
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
                      final networkImage = controller.user.value.profilePicture;
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
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text("Change Profile Picture"))
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: "Profile Information", showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                  onPressed: () => Get.to(() => const ChangeName()),
                  title: "Name",
                  value: controller.user.value.fullName),
              TProfileMenu(
                  onPressed: () {},
                  title: "Username",
                  value: controller.user.value.username),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: "Personal Information", showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Make sure to wrap these fields in Obx to watch for changes
              Obx(() {
                return TProfileMenu(
                  onPressed: () {},
                  title: "User Id",
                  value: controller.user.value.id,
                  icon: Iconsax.copy,
                );
              }),
              Obx(() {
                return TProfileMenu(
                    onPressed: () {},
                    title: "E-mail",
                    value: controller.user.value.email);
              }),
              Obx(() {
                return TProfileMenu(
                    onPressed: () {},
                    title: "Phone number",
                    value: detailsController.clientDetails.value?.phoneNumber ??
                        "Not available");
              }),
              Obx(() {
                return TProfileMenu(
                    onPressed: () {},
                    title: "Gender",
                    value: detailsController.clientDetails.value?.gender
                            ?.toString() ??
                        "Not Available");
              }),
              TProfileMenu(onPressed: () {}, title: "Date of birth", value: ""),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
