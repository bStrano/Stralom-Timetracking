import 'package:flutter/material.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/views/Home/widgets/RecordList/RecordListWidget.dart';

import 'widgets/RecordAutocompleteWidget.dart';


class TrackerHomeScreen extends StatelessWidget {
  const TrackerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entradas de tempos'),
      ),
      body: Column(
        children: [
          Row(
            children:   const [
              Expanded(
                child: RecordAutoCompleteWidget(),
              ),
              // RecordAutoCompleteWidget(),
            ],
          ),
          const Expanded(child: RecordListWidget())
        ],
      )
    );
  }
}
