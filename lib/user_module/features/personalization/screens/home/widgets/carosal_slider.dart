import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_store/user_module/features/personalization/screens/home/widgets/carosal_item.dart';
import 'package:t_store/user_module/features/personalization/screens/training/training.dart';
import 'package:t_store/utils/helpers/helper_functions.dart'; // Import Training screen

class CustomCarouselSlider extends StatefulWidget {
  final List<CarouselItem> carouselItems;

  const CustomCarouselSlider({
    super.key,
    required this.carouselItems,
  });

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 500.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 15),
            enlargeCenterPage: false,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.carouselItems.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => const Training());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.zero,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isDarkMode
                                  ? const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.3)
                                  : Colors.white.withOpacity(0.3),
                              BlendMode.darken,
                            ),
                            child: Image.asset(
                              item.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 19.0),
                              Text(
                                item.subtitle,
                                style: GoogleFonts.bebasNeue(
                                  height: 1,
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color.fromARGB(
                                          255, 247, 245, 245),
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                height: 40,
                                width: 140,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.white,
                                      ),
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0), // Adjust padding
                                      minimumSize: const Size(140,
                                          40), // Set minimum size to ensure button doesn't shrink
                                    ),
                                    child: Text(
                                      item.buttonText,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        overflow: TextOverflow
                                            .ellipsis, // Handle text overflow
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.carouselItems.length,
              (index) => Container(
                height: 2.0,
                width: _currentIndex == index
                    ? 12.0
                    : 12.0, // Adjust width for selected/unselected indicators
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? isDarkMode
                          ? Colors.white
                          : Colors.black
                      : Colors.grey, // Change color based on selection
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
