import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      backgroundColor: dark ? TColors.darkGrey : TColors.white,
      showBorder: true,
      padding: const EdgeInsets.only(
          top: TSizes.md, left: TSizes.sm, right: TSizes.sm, bottom: TSizes.sm),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Have a promo code? Enter here',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
            ),
          ),
          SizedBox(
            width: 80,
            child: TextButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor:
                        dark ? TColors.white : TColors.dark.withOpacity(0.5),
                    backgroundColor: TColors.darkerGrey.withOpacity(0.5)),
                onPressed: () {},
                child: const Text('Apply')),
          )
        ],
      ),
    );
  }
}
