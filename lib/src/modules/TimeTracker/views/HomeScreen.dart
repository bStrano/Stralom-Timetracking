import 'package:flutter/material.dart';

class TrackerHomeScreen extends StatelessWidget {
  const TrackerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrackerHomeScreen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Tracker Home Screen!'),
        ),
      ),
    );
  }
}
