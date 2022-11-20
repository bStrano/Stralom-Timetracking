import 'package:flutter/material.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/views/Home/widgets/RecordList/RecordListWidget.dart';
import '../../providers/TimeTrackerProvider.dart';
import 'widgets/ActiveRecord/ActiveRecordWidget.dart';
import 'widgets/RecordAutocompleteWidget.dart';
import 'package:provider/provider.dart';

class TrackerHomeScreen extends StatefulWidget {
  const TrackerHomeScreen({super.key});

  @override
  State<TrackerHomeScreen> createState() => _TrackerHomeScreenState();
}

class _TrackerHomeScreenState extends State<TrackerHomeScreen> {
  @override
  void initState() {
    super.initState();
    final TimeTrackerProvider timeTrackerProvider =
        Provider.of(context, listen: false);
    timeTrackerProvider.getAll();
  }

  @override
  Widget build(BuildContext context) {
    final TimeTrackerProvider timeTrackerProvider =
        Provider.of(context, listen: true);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/time-record/register',
            );
          },
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add),
        ),
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
            const ActiveRecordWidget(),
            FutureBuilder(
                future: timeTrackerProvider.timeTrackerRecordFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading');
                  } else if (snapshot.hasData) {
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
