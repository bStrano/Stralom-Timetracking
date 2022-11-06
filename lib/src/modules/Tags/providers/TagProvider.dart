import 'package:flutter/material.dart';
import 'package:stralom_timetracking/src/modules/Tags/entities/Tag.dart';

import '../apis/TagAPI.dart';

class TagProvider with ChangeNotifier {
  late Future<List<Tag>> tagsFuture;
  List<Tag> tags = [];

  Future<List<Tag>> getAll(){
    tagsFuture = fetchAll().then((value) => tags = value);
    return tagsFuture;
  }

  Future<Tag> register(Tag tag) async{
    Tag tagRes = await save(tag);
    getAll();
    notifyListeners();
    return tagRes;
  }
}
