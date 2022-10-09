import 'package:flutter/material.dart';

import '../../TimeTracker/views/Home/widgets/RecordAutocompleteWidget.dart';
import '../../TimeTracker/views/Home/widgets/RecordTagDropdownWidget.dart';

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardHomeScreen'),
      ),
      body: Row(
        children:  const [
          Expanded(
            child: RecordAutoCompleteWidget(),
          ),
           RecordTagDropdownWidget(),
        ],
      ),
    );
  }
}
