import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/images/circular_image.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/user_module/features/shop/screens/profile/profile.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.put(UserController());

    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty ? networkImage : TImages.user;
        return TCircularImage(
          padding: 4,
          isNetworkImage: true,
          image: image,
          width: 50,
          height: 50,
        );
      }),
      title: Text(
        'Allen Wasim',
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        'allenwasimk@gmail.com',
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
          onPressed: () => Get.to(() => const ProfileScreen()),
          icon: Icon(
            Iconsax.edit,
            color: TColors.white,
          )),
    );
  }
}
