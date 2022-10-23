import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../shared/constants/endpoints.dart';
import '../entities/TimeRecordsGroupedByStart.dart';

Future<List<TimeRecordGroupedByStart>> fetchTimeRecordGroupedByDate() async {
  final response = await http
      .get(Uri.parse('${HOST}records?groupBy=start'));

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body) as List;
    return body.map( (item) => TimeRecordGroupedByStart.fromJson(item)).toList() ;
  } else {
    throw Exception('Failed to load records');
  }
}