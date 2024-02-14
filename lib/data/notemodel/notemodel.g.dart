// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notemodel _$NotemodelFromJson(Map<String, dynamic> json) => Notemodel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$NotemodelToJson(Notemodel instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'content': instance.content,
    };
