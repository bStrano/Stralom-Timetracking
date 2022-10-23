import 'package:flutter/material.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/apis/TimeRecordApi.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/entities/TimeRecordsGroupedByStart.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/views/Home/widgets/RecordList/RecordListWidget.dart';

import 'widgets/RecordAutocompleteWidget.dart';

class TrackerHomeScreen extends StatefulWidget {
  const TrackerHomeScreen({super.key});

  @override
  State<TrackerHomeScreen> createState() => _TrackerHomeScreenState();
}

class _TrackerHomeScreenState extends State<TrackerHomeScreen> {
  late Future<List<TimeRecordGroupedByStart>> timeTrackerRecord;

  @override
  void initState() {
    super.initState();
    timeTrackerRecord =  fetchTimeRecordGroupedByDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Entradas de tempos'),
        ),
        body: Column(
          children: [
            Row(
              children: const [
                Expanded(
                  child: RecordAutoCompleteWidget(),
                ),
                // RecordAutoCompleteWidget(),
              ],
            ),
            FutureBuilder(
                future: timeTrackerRecord,
                builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RecordListWidget(records: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            }),
          ],
        ));
  }
}
