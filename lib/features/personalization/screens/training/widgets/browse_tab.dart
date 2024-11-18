import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/searchbars/search_bar.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Column(
        children: [
          // Search bar

          const TSearchBar(),

          // Image grid
          const SizedBox(
            height: 4,
          ),
          Expanded(
            child: ListView(
              children: [
                buildCategoryItem(
                    context, TImages.browseImage1, 'Workout Focus'),
                buildCategoryItem(
                    context, TImages.browseImage2, 'Muscle Group'),
                buildCategoryItem(context, TImages.browseImage3, 'Equipment'),
              ],
            ),
          ),
        ],
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
        margin: const EdgeInsets.only(bottom: 4.0),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(2, 2),
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
