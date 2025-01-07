import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigateToMeetPage extends StatelessWidget {
  final String meetUrl;

  const NavigateToMeetPage({Key? key, required this.meetUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Google Meet'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => launchMeet(context, meetUrl),
          child: const Text('Open Google Meet'),
        ),
      ),
    );
  }

  // Directly launches the URL
  static Future<void> launchMeet(BuildContext context, String url) async {
    final Uri meetUri = Uri.parse(_ensureValidUrl(url));
    print("Launching Meet URL: $meetUri");

    // Try to launch the Meet URL directly
    try {
      await launchUrl(meetUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print("Unable to open Meet URL: $meetUri");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open Google Meet')),
      );
    }
  }

  // Ensure URL has a valid scheme (add https:// if missing)
  static String _ensureValidUrl(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url'; // Add https:// if missing
    }
    return url;
  }
}
