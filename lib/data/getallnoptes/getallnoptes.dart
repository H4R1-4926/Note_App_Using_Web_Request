import 'package:json_annotation/json_annotation.dart';
import 'package:note_app/data/notemodel/notemodel.dart';

part 'getallnoptes.g.dart';

@JsonSerializable()
class Getallnotes {
  @JsonKey(name: 'data')
  List<Notemodel> data;

  Getallnotes({this.data = const []});

  factory Getallnotes.fromJson(Map<String, dynamic> json) {
    return _$GetallnotesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetallnotesToJson(this);
}
