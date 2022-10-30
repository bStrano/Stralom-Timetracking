import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/entities/TimeRecord.dart';
import '../../../../providers/TimeTrackerProvider.dart';

class ActiveRecordWidget extends StatefulWidget {
  const ActiveRecordWidget({Key? key}) : super(key: key);

  @override
  State<ActiveRecordWidget> createState() => _ActiveRecordWidgetState();
}

class _ActiveRecordWidgetState extends State<ActiveRecordWidget> {
  TimeRecord? _timeRecord;
  Timer? timer;

  updateElapsedTime(){
    final TimeTrackerProvider timeTrackerProvider = Provider.of(context, listen: false);

    if(timeTrackerProvider.activeTimeRecord == null) return 0;
    DateTime now = DateTime.now();
    int elapsedTime = now.difference(timeTrackerProvider.activeTimeRecord!.start).inSeconds;
    timeTrackerProvider.activeTimeRecord?.elapsedTime = elapsedTime;
    setState(() {
      _timeRecord = timeTrackerProvider.activeTimeRecord;
    });
  }



  @override
  void initState() {
    super.initState();
    final TimeTrackerProvider timeTrackerProvider = Provider.of(context, listen: false);
    timeTrackerProvider.getActive().then((value) => _timeRecord = value);
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => updateElapsedTime());
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TimeTrackerProvider timeTrackerProvider = Provider.of(context, listen: true);

    return FutureBuilder(
        future: timeTrackerProvider.activeTimeRecordFuture,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading');
          }
          if (snapshot.data != null) {
            return Container(
              padding: const EdgeInsets.fromLTRB(18, 20, 20, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(snapshot.data!.title),
                  ),
                  Text(_timeRecord!.getFormattedElapsedTime()),
                  IconButton(
                    onPressed: () async => await timeTrackerProvider.stopTrackingRecord(_timeRecord!.id),
                    icon: const Icon(
                      Icons.stop_circle,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        });
  }
}
