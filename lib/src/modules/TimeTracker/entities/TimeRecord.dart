import 'package:json_annotation/json_annotation.dart';

part 'TimeRecord.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeRecord {
  TimeRecord(this.userId, this.id, this.title, this.start, this.end);

  int userId;
  int id;
  String title;
  DateTime start;
  DateTime? end;


  factory TimeRecord.fromJson(Map<String, dynamic> json) => _$TimeRecordFromJson(json);
  Map<String, dynamic> toJson() => _$TimeRecordToJson(this);


}