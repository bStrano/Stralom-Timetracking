import 'dart:convert';

import '../../../shared/constants/endpoints.dart';
import '../entities/Tag.dart';
import 'package:http/http.dart' as http;

Future<List<Tag>> fetchAll() async {
  final response = await http.get(Uri.parse('${HOST}tags'));

  if (response.statusCode == 200) {
    print(response.body);
    var body = jsonDecode(response.body) as List;
    return body.map((e) => Tag.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load projects');
  }
}

Future<Tag> save(Tag tag) async {
  final response = await http.post(
    Uri.parse('${HOST}tags'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'color': tag.color,
      'name': tag.name
    }),
  );

  if (response.statusCode == 201) {
    var body = jsonDecode(response.body);
    return Tag.fromJson(body);
  } else {
    throw Exception('Failed to load projects');
  }
}
