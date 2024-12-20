import 'dart:ui';

import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget _buildCard(
      String title, IconData icon, Color iconColor, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.5,
          children: [
            _buildCard('Expired (1-3 days)', Icons.person_remove_alt_1,
                Colors.teal, '0'),
            _buildCard('Expired (4-7 days)', Icons.person_remove_alt_1,
                Colors.teal, '0'),
            _buildCard('Expired (8-15 days)', Icons.person_remove_alt_1,
                Colors.teal, '0'),
            _buildCard(
                'Expiry Today', Icons.person_remove_alt_1, Colors.teal, '0'),
            _buildCard('Today Attendance', Icons.access_time, Colors.teal, '0'),
            _buildCard(
                'Today Collection', Icons.attach_money, Colors.green, '0'),
            _buildCard('Due Amount', Icons.money_off, Colors.red, '0'),
            _buildCard('Birthday', Icons.cake, Colors.teal, '0'),
            _buildCard('Block Members', Icons.block, Colors.teal, '0'),
            _buildCard(
                'Total Collection', Icons.attach_money, Colors.green, '0'),
            _buildCard('Total Members', Icons.groups, Colors.teal, '0'),
            _buildCard('Active Members', Icons.groups, Colors.green, '0'),
            _buildCard(
                'Expired Members', Icons.person_remove_alt_1, Colors.red, '0'),
          ],
        ),
      ),
    );
  }
}
