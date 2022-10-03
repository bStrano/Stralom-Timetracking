import 'package:flutter/material.dart';

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardHomeScreen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Dashboard Home Screen'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}
