
import 'package:json_annotation/json_annotation.dart';

part 'Project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  int? id;
  String name;
  String color;

  Project(this.id, this.name, this.color);

  Project.fromForm(this.name, this.color);

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  String toString(){
    return name;
  }

  @override
  bool operator == (Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Project && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hash(id, name);
}
