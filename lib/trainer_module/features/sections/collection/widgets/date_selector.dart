import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Function(DateTime) onDateSelected;

  const DateSelector({
    required this.controller,
    required this.label,
    required this.icon,
    required this.onDateSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () async {
        // Show date picker when the text field is tapped
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (selectedDate != null) {
          controller.text =
              "${selectedDate.toLocal()}".split(' ')[0]; // Format date
          onDateSelected(
              selectedDate); // Call the callback with the selected date
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
            prefixIcon: Icon(
              icon,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
            border: InputBorder.none, // No border for a clean, rounded look
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          readOnly: true, // Prevent manual editing
          style: TextStyle(
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
