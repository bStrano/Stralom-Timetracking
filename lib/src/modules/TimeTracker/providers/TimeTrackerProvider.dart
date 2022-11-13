import 'package:flutter/material.dart';

import '../apis/TimeRecordApi.dart';
import '../entities/TimeRecord.dart';
import '../entities/TimeRecordsGroupedByStart.dart';

class TimeTrackerProvider with ChangeNotifier {
  late Future<List<TimeRecordGroupedByStart>> timeTrackerRecordFuture;
  List<TimeRecordGroupedByStart>? timeTrackerRecord;

  late Future<TimeRecord> activeTimeRecordFuture;
  TimeRecord? activeTimeRecord;

  Future<List<TimeRecordGroupedByStart>> getAll() {
    timeTrackerRecordFuture = fetchTimeRecordGroupedByDate()
        .then((value) => timeTrackerRecord = value);
    return timeTrackerRecordFuture;
  }

  Future<TimeRecord> getActive() {
    activeTimeRecordFuture =
        fetchActiveRecord().then((value) => activeTimeRecord = value);
    return activeTimeRecordFuture;
  }

  Future<void> save(TimeRecord record) async {
    await save(record);
    getActive();
    getAll();
    notifyListeners();
  }

  Future<void> startTrackingRecord(String value) async {
    await startTracking(value);
    getActive();
    getAll();
    notifyListeners();
  }

  Future<void> stopTrackingRecord(int id) async {
    await stopTracking(id);
    getActive();
    getAll();
    notifyListeners();
  }
}
