import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveSessionRepository {
  // Method to open a Google Meet URL
  Future<void> openMeetSession(BuildContext context, String meetUrl) async {
    final Uri meetUri = Uri.parse(_ensureValidUrl(meetUrl));
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

  // Ensure the URL has a valid scheme (add https:// if missing)
  String _ensureValidUrl(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url'; // Add https:// if missing
    }
    return url;
  }
}

// Example widget that uses LiveSessionRepository
class LiveSessionScreen extends StatelessWidget {
  final String meetUrl;
  final LiveSessionRepository liveSessionRepository = LiveSessionRepository();

  LiveSessionScreen({Key? key, required this.meetUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Session'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              liveSessionRepository.openMeetSession(context, meetUrl),
          child: const Text('Join Live Session'),
        ),
      ),
    );
  }
}
