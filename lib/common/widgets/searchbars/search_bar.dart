import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TSearchBar extends StatelessWidget {
  const TSearchBar({
    super.key,
    this.textColor,
    this.backgroundColor, // Added backgroundColor argument
  });

  final Color? textColor;
  final Color? backgroundColor; // Define the backgroundColor

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(TSizes.spaceBtwInputFields),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: textColor ?? (dark ? Colors.white : Colors.black),
            size: 18,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(
              fontSize: 15,
              color: textColor ?? (dark ? Colors.white : Colors.black)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: dark ? Colors.white : Colors.white,
              width: 0.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: dark ? Colors.grey : Colors.black,
              width: .50,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          fillColor: backgroundColor ??
              (dark
                  ? Colors.black.withOpacity(0.1)
                  : Colors.white), // Apply backgroundColor or default
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 20.0,
          ),
        ),
      ),
    );
  }
}
