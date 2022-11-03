import 'dart:convert';

import 'package:stralom_timetracking/src/modules/Projects/entities/Project.dart';
import 'package:http/http.dart' as http;

import '../../../shared/constants/endpoints.dart';

Future<List<Project>> fetchAll() async {
  final response = await http.get(Uri.parse('${HOST}projects'));


  if(response.statusCode == 200) {
    print(response.body);
    var body = jsonDecode(response.body) as List;
    return body.map((e) => Project.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load projects');
  }
}
