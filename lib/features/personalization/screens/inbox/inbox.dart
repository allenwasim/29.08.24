import 'package:flutter/material.dart';

class NotificationInboxScreen extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'New Message',
      subtitle: 'You have received a new message from John Doe.',
      timestamp: '10:30 AM',
    ),
    NotificationItem(
      title: 'Appointment Reminder',
      subtitle: 'Your appointment with Dr. Smith is scheduled for tomorrow.',
      timestamp: '9:15 AM',
    ),
    NotificationItem(
      title: 'Subscription Expiry',
      subtitle: 'Your subscription is about to expire. Renew now!',
      timestamp: 'Yesterday',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: Icon(Icons.notifications, color: Colors.green),
            title: Text(notification.title),
            subtitle: Text(notification.subtitle),
            trailing: Text(notification.timestamp,
                style: TextStyle(color: Colors.grey)),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            onTap: () {
              // Handle notification tap
              print('Notification tapped: ${notification.title}');
            },
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String subtitle;
  final String timestamp;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.timestamp,
  });
}
