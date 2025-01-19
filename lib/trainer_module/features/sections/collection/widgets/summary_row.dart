import 'package:flutter/material.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String monthlyEarnings;
  final String totalEarnings;
  final bool isSearchPerformed; // New argument

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.monthlyEarnings,
    required this.totalEarnings,
    required this.isSearchPerformed, // New argument
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: isDark
          ? Colors.grey[800]
          : Colors.grey[200], // Dark mode and light mode background colors
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? Colors.white
                        : Colors.black87, // Title color based on theme
                  ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            SummaryRow(
              label: 'Total Earnings',
              amount: totalEarnings,
              isDark: isDark, // Pass dark mode status
            ),
            SummaryRow(
              label: 'Monthly Earnings',
              amount: monthlyEarnings,
              isDark: isDark, // Pass dark mode status
            ),
            // Conditionally render the "Earnings Between Selected Dates" card
            if (isSearchPerformed)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Earnings Between Selected Dates',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹ $amount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green, // Green for selected date earnings
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isDark;

  const SummaryRow({
    super.key,
    required this.label,
    required this.amount,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? Colors.white70
                  : Colors.black54, // Adjust label color for both themes
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  '₹ $amount',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: label == 'Monthly Earnings'
                        ? (isDark
                            ? Colors.greenAccent
                            : Colors.green) // Green for monthly earnings
                        : (isDark
                            ? Colors.blueAccent
                            : Colors.blue), // Blue for total earnings
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
