import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String value;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.value,
  }) : super(key: key);

  // Reusable method for the card header (icon and value)
  Widget _buildCardHeader(IconData icon, Color iconColor, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        Icon(
          icon,
          size: 28,
          color: iconColor,
        ),
      ],
    );
  }

  // Reusable method for the card title
  Widget _buildCardTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCardHeader(icon, iconColor, value),
            const SizedBox(height: 8),
            _buildCardTitle(title),
          ],
        ),
      ),
    );
  }
}
