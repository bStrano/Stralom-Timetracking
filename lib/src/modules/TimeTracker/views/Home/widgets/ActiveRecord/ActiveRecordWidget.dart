import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/entities/TimeRecord.dart';

import '../../../../apis/TimeRecordApi.dart';

class ActiveRecordWidget extends StatefulWidget {
  const ActiveRecordWidget({Key? key}) : super(key: key);

  @override
  State<ActiveRecordWidget> createState() => _ActiveRecordWidgetState();
}

class _ActiveRecordWidgetState extends State<ActiveRecordWidget> {
  late Future<TimeRecord> _timeTrackerRecord;
  TimeRecord? _timeRecord;
  Timer? timer;


  updateElapsedTime(){
    if(_timeRecord == null) return 0;
    DateTime now = DateTime.now();
    int elapsedTime = now.difference(_timeRecord!.start).inSeconds;
    _timeRecord?.elapsedTime = elapsedTime;
    setState(() {
      _timeRecord = _timeRecord;
    });
  }

  @override
  void initState() {
    super.initState();
    _timeTrackerRecord = fetchActiveRecord().then((value) => _timeRecord = value);
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => updateElapsedTime());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _timeTrackerRecord,
        builder: (context, snapshot) {
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
                    onPressed: () async => await stopTracking(_timeRecord!.id),
                    icon: const Icon(
                      Icons.stop_circle,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }
          return Text('snapshot.data');
        });
  }
}
