import 'package:flutter/cupertino.dart';
import 'package:stralom_timetracking/src/modules/Projects/apis/ProjectAPI.dart';
import 'package:stralom_timetracking/src/modules/Projects/entities/Project.dart';

class ProjectProvider with ChangeNotifier {
  late Future<List<Project>> projectsFuture;
  List<Project> projects = [];

  Future<List<Project>> getAll(){
    projectsFuture = fetchAll().then((value) => projects = value);
    return projectsFuture;
  }

  Future<Project> register(Project project) async{
    Project projectRes = await save(project);
    getAll();
    notifyListeners();
    return projectRes;
  }
}
