import 'package:json_annotation/json_annotation.dart';

part 'notemodel.g.dart';

@JsonSerializable()
class Notemodel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  String? content;

  Notemodel({this.id, this.title, this.content});

  Notemodel.create({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Notemodel.fromJson(Map<String, dynamic> json) {
    return _$NotemodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotemodelToJson(this);
}
