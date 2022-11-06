import 'dart:convert';

import 'package:stralom_timetracking/src/modules/Projects/entities/Project.dart';
import 'package:http/http.dart' as http;

import '../../../shared/constants/endpoints.dart';

Future<List<Project>> fetchAll() async {
  final response = await http.get(Uri.parse('${HOST}projects'));

  if (response.statusCode == 200) {
    print(response.body);
    var body = jsonDecode(response.body) as List;
    return body.map((e) => Project.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load projects');
  }
}

Future<Project> save(Project project) async {
  final response = await http.post(
    Uri.parse('${HOST}projects'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'color': project.color,
      'name': project.name
    }),
  );

  if (response.statusCode == 201) {
    var body = jsonDecode(response.body);
    return Project.fromJson(body);
  } else {
    throw Exception('Failed to load projects');
  }
}
