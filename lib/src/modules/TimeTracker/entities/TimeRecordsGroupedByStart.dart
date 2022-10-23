import 'package:json_annotation/json_annotation.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/entities/TimeRecord.dart';

part 'TimeRecordsGroupedByStart.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeRecordGroupedByStart {
  TimeRecordGroupedByStart(this.date, this.records);

  DateTime date;
  List<TimeRecord> records;


  factory TimeRecordGroupedByStart.fromJson(Map<String, dynamic> json) => _$TimeRecordGroupedByStartFromJson(json);
  Map<String, dynamic> toJson() => _$TimeRecordGroupedByStartToJson(this);

}