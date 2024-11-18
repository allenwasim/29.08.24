import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/personalization/controllers/update_name_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/validators/validation.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'dopa',
                style: Theme.of(context).textTheme.headlineLarge!.apply(
                      color: dark
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : Colors.black,
                    ),
              ),
              TextSpan(
                text: 'Mine',
                style: Theme.of(context).textTheme.headlineLarge!.apply(
                      color: dark ? const Color(0xff4caf50) : Colors.green,
                    ),
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: dark ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: dark ? Colors.white : Colors.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Form(
              key: controller.updateNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstNameController,
                    validator: (value) =>
                        TValidator.validateEmptyText('First Name', value),
                    expands: false,
                    decoration: InputDecoration(
                        labelText: TTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TextFormField(
                    controller: controller.lastNameController,
                    validator: (value) =>
                        TValidator.validateEmptyText('Last Name', value),
                    expands: false,
                    decoration: InputDecoration(
                        labelText: TTexts.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () =>
                      controller.updateUserName(), // Corrected this line
                  child: Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
