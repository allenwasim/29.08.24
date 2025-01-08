import 'package:flutter/material.dart';
import 'package:t_store/user_module/data/repositories/client/live_session_repository.dart';

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
