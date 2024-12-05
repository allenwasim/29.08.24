import 'package:flutter/material.dart';
import 'package:t_store/common/appbar/appbar.dart';
import 'package:t_store/common/widgets/product/ratings/rating_indicator.dart';
import 'package:t_store/user_module/features/shop/screens/product_review_screen.dart/widgets/overall_product_rating.dart';
import 'package:t_store/user_module/features/shop/screens/product_review_screen.dart/widgets/user_review.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductReviewsScreen extends StatelessWidget {
  const TProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const TAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ratings and reviews are verified and are from people who use the same type of device that you use.",
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Overall Product Ratings
              const TOverallProductRating(),
              const TRatingBarIndicator(
                rating: 4.8,
              ),
              Text(
                '12,611',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
