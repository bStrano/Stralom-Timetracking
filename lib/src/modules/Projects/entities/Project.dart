
import 'package:json_annotation/json_annotation.dart';

part 'Project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  int id;
  String name;

  Project(this.id, this.name);

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
