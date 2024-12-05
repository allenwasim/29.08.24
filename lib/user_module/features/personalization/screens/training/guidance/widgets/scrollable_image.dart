import 'package:flutter/material.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class CarouselItem {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onButtonPressed;

  CarouselItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onButtonPressed,
  });
}

class TScrollableImage extends StatelessWidget {
  final List<CarouselItem> items;

  const TScrollableImage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return SizedBox(
      height: 330, // Adjusted height for the horizontal list view
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 250,
            margin: const EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image container
                Container(
                  width: 250,
                  height: 250, // Adjusted height for the image
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    image: DecorationImage(
                      image: AssetImage(item.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Title and subtitle container
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: dark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.orangeAccent,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
