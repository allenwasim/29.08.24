import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/controllers/collection_controller.dart';
import 'package:t_store/trainer_module/features/sections/collection/widgets/summary_row.dart';
import 'package:t_store/trainer_module/features/sections/collection/widgets/date_selector.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final CollectionController controller = Get.put(CollectionController());
  DateTime? fromDate;
  DateTime? toDate;
  bool isSearchPerformed = false; // Track if the search button was clicked

  // TextEditingController to show the date selected
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Fetch collections when the widget is built
    controller.fetchAllCollections(DateTime.now().year, DateTime.now().month);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Filters
            Row(
              children: [
                Expanded(
                  child: DateSelector(
                    controller: fromDateController,
                    label: 'From Date',
                    icon: Icons.calendar_today,
                    onDateSelected: (selectedDate) {
                      setState(() {
                        fromDate = selectedDate;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DateSelector(
                    controller: toDateController,
                    label: 'To Date',
                    icon: Icons.calendar_today,
                    onDateSelected: (selectedDate) {
                      setState(() {
                        toDate = selectedDate;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Search and Clear Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TCircularButton(
                  backgroundColor: isDark ? Colors.grey[800] : Colors.white,
                  textColor: TColors.trainerPrimary,
                  text: 'Search',
                  onTap: () {
                    if (fromDate != null && toDate != null) {
                      controller.fetchCollectionsBetweenDates(
                          fromDate!, toDate!);
                      setState(() {
                        isSearchPerformed = true; // Mark search as performed
                      });
                    }
                  },
                ),
                TCircularButton(
                  backgroundColor: Colors.transparent,
                  textColor: isDark ? Colors.white : TColors.black,
                  text: 'Clear',
                  onTap: () {
                    setState(() {
                      fromDate = null;
                      toDate = null;
                      isSearchPerformed = false; // Reset search status
                      fromDateController.clear();
                      toDateController.clear();
                    });
                    controller.resetCollections();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Note
            const Text(
              'Note: The date filter is applied to the plan start date.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Plan Collection Summary (Always Visible)

            // Conditionally render the "Earnings Between Dates" card when search is performed
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return SummaryCard(
                title: isSearchPerformed
                    ? 'Earnings Between Selected Dates'
                    : 'Collection Summary',
                amount: isSearchPerformed
                    ? controller.totalCollectionForDateRange.value.toString()
                    : controller.totalCollection.value.toString(),
                monthlyEarnings: controller.monthlyCollection.value.toString(),
                totalEarnings: controller.totalCollection.value.toString(),
                isSearchPerformed: isSearchPerformed, // Pass the flag
              );
            })
          ],
        ),
      ),
    );
  }
}
