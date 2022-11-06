import 'package:json_annotation/json_annotation.dart';

part 'Tag.g.dart';

@JsonSerializable(explicitToJson: true)
class Tag {
  int? id;
  String name;
  String color;

  Tag(this.id, this.name, this.color){}

  Tag.fromForm(this.name, this.color);


  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);


  @override
  String toString(){
    return name;
  }

  @override
  bool operator == (Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Tag && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hash(id, name);
}
