import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/image_text_widget/vertical_image_text.dart';
import 'package:t_store/common/widgets/shimmer/category_shimmer.dart';
import 'package:t_store/user_module/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:t_store/user_module/features/shop/controllers/category_controller.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) {
        return const TCategoryShimmer();
      }
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
            child: Text('No Data Found!',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Colors.white)));
      }
      return SizedBox(
          height: 80,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryController.featuredCategories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final category = categoryController.featuredCategories[index];
                return TVerticalImageText(
                  image: category.image,
                  title: category.name,
                  onTap: () => Get.to(() => const TSubCategories()),
                  isNetworkImage: true,
                );
              }));
    });
  }
}
