import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../shared/constants/endpoints.dart';
import '../../Tags/entities/Tag.dart';
import '../entities/TimeRecord.dart';
import '../entities/TimeRecordsGroupedByStart.dart';

Future<List<TimeRecordGroupedByStart>> fetchTimeRecordGroupedByDate() async {
  final response = await http.get(Uri.parse('${HOST}records?groupBy=start'));

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body) as List;
    return body.map((item) => TimeRecordGroupedByStart.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load records');
  }
}

Future<TimeRecord> fetchActiveRecord() async {
  final response = await http.get(Uri.parse('${HOST}records/current'));

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    return TimeRecord.fromJson(body);
  } else {
    throw Exception('Failed to load active record');
  }
}

Future<void> startTracking(String title) async {
  final response = await http.post(
    Uri.parse('${HOST}records/start'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    print('Saved');
  } else {
    throw Exception('Failed start tracking record.');
  }
}

Future<void> save(String title, DateTime? start, DateTime? end, List<Tag>? tags, int? projectId) async {
  final response = await http.post(
    Uri.parse('${HOST}records'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode({
      'title': title,
      'start': start != null ? '${start.toIso8601String()}Z' : null,
      'end': end != null ? '${end.toIso8601String()}Z' : null,
      'tags': tags?.map((e) => {'id': e.id}).toList(),
      'projectId': projectId,
    }),
  );

  if (response.statusCode == 201) {
    print('Saved');
  } else {
    throw Exception('Failed start tracking record.');
  }
}

Future<void> stopTracking(int id) async {
  final response = await http.patch(
    Uri.parse('${HOST}records/stop/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    print('Stoped');
  } else {
    throw Exception('Failed stop tracking record.');
  }
}
