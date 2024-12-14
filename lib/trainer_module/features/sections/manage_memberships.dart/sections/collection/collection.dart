import 'package:flutter/material.dart';

class CollectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Filters
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'From Date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'To Date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Search and Clear Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Search'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Note
            Text(
              'Note: The date filter is applied to the plan start date.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 16),

            // Plan Collection Summary
            SummaryCard(title: 'Plan Collection Summary'),
            SizedBox(height: 16),

            // Service Collection Summary
            Text(
              'Service Collection Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;

  SummaryCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Divider(),
            _buildSummaryRow('Total Membership', '0', '0', '0'),
            Divider(),
            _buildSummaryRow('Completely Paid', '0', '0', '0'),
            Divider(),
            _buildSummaryRow('Remainder Balance', '0', '0', '0'),
            Divider(),
            _buildSummaryRow('Unpaid Payment', '0', '0', '0'),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
      String label, String amount, String received, String balanceDue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Complete Amount: $amount'),
            Text('₹ Received: $received'),
            Text('₹ Balance due: $balanceDue',
                style: TextStyle(color: Colors.red)),
          ],
        ),
      ],
    );
  }
}
