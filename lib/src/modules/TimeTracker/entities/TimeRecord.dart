import 'package:json_annotation/json_annotation.dart';

import '../../Tags/entities/Tag.dart';

part 'TimeRecord.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeRecord {
  TimeRecord(this.userId, this.id, this.title, this.start, this.end);

  int userId;
  int id;
  String title;
  DateTime start;
  DateTime? end;
  @JsonKey(ignore: true)
  int elapsedTime = 0;
  List<Tag> tags = [];


  factory TimeRecord.fromJson(Map<String, dynamic> json) => _$TimeRecordFromJson(json);
  Map<String, dynamic> toJson() => _$TimeRecordToJson(this);

  // TimeRecord.fromForm(this.title, this.start, this.end);


  getFormattedElapsedTime(){
    int seconds = elapsedTime%60;
    int minutes = (elapsedTime/60%60).floor();
    int hours = ((elapsedTime/(60*60))%60).floor();

    return '${_formatElapsedTime(hours)}:${_formatElapsedTime(minutes)}:${_formatElapsedTime(seconds)}';
  }

  String _formatElapsedTime(int time){
    if(time < 10){
        return '0$time';
    }
    return time.toString();
  }

}
