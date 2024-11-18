import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/constants/colors.dart';

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    super.key,
    required this.rating,
  });
  final double rating;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: rating,
        unratedColor: TColors.grey,
        itemSize: 17,
        itemCount: 5,
        itemBuilder: (_, __) => const Icon(
              Iconsax.star1,
              color: Colors.green,
            ));
  }
}
