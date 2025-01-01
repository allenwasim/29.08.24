import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/controllers/add_plans_controller.dart';

class AddPlanScreen extends StatelessWidget {
  final String trainerId;

  const AddPlanScreen({super.key, required this.trainerId});

  @override
  Widget build(BuildContext context) {
    final AddPlansController controller = Get.put(AddPlansController());

    // Generate price options (0 to 5000 in increments of 100)
    final List<int> priceOptions = List.generate(51, (index) => index * 100);

    // Define duration options with values in months
    final List<String> durationOptions = [
      '1 Month',
      '3 Months',
      '6 Months',
      '1 Year'
    ];

    // Map the selected duration string to its corresponding month value
    int mapDurationToMonths(String duration) {
      switch (duration) {
        case '1 Month':
          return 1;
        case '3 Months':
          return 3;
        case '6 Months':
          return 6;
        case '1 Year':
          return 12;
        default:
          return 1; // Default to 1 month
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Membership Plan'),
        backgroundColor: TColors.trainerPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Plan Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the plan name';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.name.value = value,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.description.value = value,
                ),
                const SizedBox(height: 16),

                // Price Dropdown
                DropdownButtonFormField<int>(
                  decoration:
                      const InputDecoration(labelText: 'Price (/month)'),
                  value: controller.price.value.toInt(),
                  items: priceOptions
                      .map((price) => DropdownMenuItem(
                            value: price,
                            child: Text('₹$price'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.price.value = value.toDouble();
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Duration Dropdown
                Obx(() {
                  // Ensure controller.duration.value is within a valid range
                  final selectedIndex = (controller.duration.value > 0 &&
                          controller.duration.value <= durationOptions.length)
                      ? controller.duration.value - 1
                      : 0; // Default to the first option if invalid

                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Duration'),
                    value: durationOptions[selectedIndex],
                    items: durationOptions
                        .map((duration) => DropdownMenuItem(
                              value: duration,
                              child: Text(duration),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.duration.value = mapDurationToMonths(value);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a duration';
                      }
                      return null;
                    },
                  );
                }),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Workouts Included',
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Obx(() => Wrap(
                            spacing: 10,
                            children:
                                controller.availableWorkouts.map((workout) {
                              return ChoiceChip(
                                label: Text(workout),
                                selected: controller.workouts.contains(workout),
                                onSelected: (selected) {
                                  if (selected) {
                                    controller.workouts.add(workout);
                                  } else {
                                    controller.workouts.remove(workout);
                                  }
                                },
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Obx(() => SwitchListTile(
                      title: const Text('Available now'),
                      value: controller.isAvailable.value,
                      onChanged: (value) {
                        controller.isAvailable.value = value;
                      },
                    )),
                const SizedBox(height: 16),

                Center(
                  child: SizedBox(
                    width: 250,
                    child: TCircularButton(
                      text: 'Add Plan',
                      backgroundColor: TColors.primary,
                      onTap: () async {
                        await controller.addMembershipPlan(trainerId);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
